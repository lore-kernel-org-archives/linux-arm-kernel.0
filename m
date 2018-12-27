Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55245C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:08:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D496214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n1rOANLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D496214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=51faYdj1CTU7Cio/AV19LN/oUFxl8GGKqflLfvGCRKs=; b=n1rOANLkRQF3aI
	dp0YnNjoy8pHuzZCgsrVzeFaxqvndizRg5IY7iohoFgoOT/2K4+XMTU8jYSt17Uxz13cMQjhfpybP
	8l75HBWwt/DZjuPbXRtlowTZTMeYlxJ8nWnyQyO1N2Rt84oUmm9Rn+mDHon4/gWBLNtPDZGQeHV2G
	GIqai4qft14U7ACPCM+FtQRZBhYMRrJ/aBRLc/v1b0Drvrj6ExbNsy3GjrZu/P34ZkXklBcy4l3Gw
	RW1QVsRSoGDs4I+YXoNMATxJEhQijEfX6SC4va/bp6zkSu1oVjrvAo3R0RmiG3u3iw2msl2X4Lj5y
	WZuygeyVUAIV1vZ6yObA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcPlz-0000IM-7A; Thu, 27 Dec 2018 07:08:03 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcPls-0000HX-Uw
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 07:08:01 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Dec 2018 23:07:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,404,1539673200"; d="scan'208";a="110231263"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56])
 ([10.237.72.56])
 by fmsmga007.fm.intel.com with ESMTP; 26 Dec 2018 23:07:41 -0800
Subject: Re: [PATCH 2/2] mmc: sdhci-brcmstb: handle mmc_of_parse() errors
 during probe
To: Stefan Wahren <stefan.wahren@i2se.com>, Al Cooper <alcooperx@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <1545598758-4502-1-git-send-email-stefan.wahren@i2se.com>
 <1545598758-4502-2-git-send-email-stefan.wahren@i2se.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ae20c332-17a3-d135-ae93-391f1cf989d3@intel.com>
Date: Thu, 27 Dec 2018 09:06:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1545598758-4502-2-git-send-email-stefan.wahren@i2se.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_230757_044821_8CC493F7 
X-CRM114-Status: GOOD (  23.35  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 linux-mmc@vger.kernel.org, Eric Anholt <eric@anholt.net>,
 bcm-kernel-feedback-list@broadcom.com, Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 23/12/18 10:59 PM, Stefan Wahren wrote:
> We need to handle mmc_of_parse() errors during probe otherwise the
> MMC driver could start without proper initialization (e.g. power sequence).
> 
> Fixes: 476bf3d62d5c ("mmc: sdhci-brcmstb: Add driver for Broadcom BRCMSTB SoCs")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Hi,
> since i don't have this hardware, so it is only compile tested.
> Would be nice to get a Tested-by.
> 
> Regards
> Stefan 
> 
> 
>  drivers/mmc/host/sdhci-brcmstb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 552bddc..1cd1035 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -55,7 +55,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  	}
>  
>  	sdhci_get_of_property(pdev);
> -	mmc_of_parse(host->mmc);
> +	res = mmc_of_parse(host->mmc);
> +	if (res)
> +		goto err;
>  
>  	/*
>  	 * Supply the existing CAPS, but clear the UHS modes. This
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
