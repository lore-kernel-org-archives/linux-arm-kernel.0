Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D649C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:03:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB16E20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cXAA5SbX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="m2tqm55o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB16E20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qmZAedWuYfAyzNpDRLWAiTVqdPQ6relk/nFyPcE7HdM=; b=cXAA5SbXHhjU4I
	Ct5zo13lAYWCApozFO9agap5Jj+tOZnldpk/YnOD82/vlr4UL9kNhgcl+dszhmIznmBBLfCGFBcfN
	xWHqRjXgkrU90tlC6u6o7x7u6xSRGArHsKMRo84PKLgG0DaD3JOFS7z5VSDjIwAs/u3Kp1VIHfFSv
	rExH/JnKGSOe1BL59moQeUT5JnbsfU6VsAcdSURGTlktQwsuCc9XG3OaaaCnxW40ylV3bLftE5m9F
	4uaQijVSQ+Yb/+/UkSqFu7yaKzK+MhegCDgFqLsiq9VJweFc7/jlBOsg/gzsvnANB4jmiMQyAc8C6
	fG+LGgzNcF2ItxDlkZ4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi19B-0003Xh-FV; Fri, 11 Jan 2019 18:03:09 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi198-0003XA-CS
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 18:03:08 +0000
Received: by mail-lj1-x243.google.com with SMTP id v1-v6so13732676ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 10:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:organization:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2ULYO6Nnxh5VJpdAsCNWESJebEgKjFsQZG3LlzGHXOA=;
 b=m2tqm55okL0Kg7JUbX5HUqxzyfkrRNq7zIah1nSnMH5z36jFJfOueb1L52c8Bre5KT
 Uab4pPI0fttARH+TofjOzTosBz9HTH8+nhhzYAOB3wucwfJWLCjZv0JTogVrWonLcGxI
 4J2vNLqn8yPEXpqc0ix77g4BFCOZ6+udGGTPDAMp93rg71M1Ul36+SBb9MUgbqAfPqQP
 bC3de35YRSTUzPiQJ5Ek7YhOPHIxJ2YaHVwvE2CMiG8MRw4hokdWkjR128wWkPqXsuzq
 jeThgEESX8goohWIPJAZx30n7UEzOZLxGxFSplPzzBJdtxySPRFhhltX90WKMN9N3p6l
 Vi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=2ULYO6Nnxh5VJpdAsCNWESJebEgKjFsQZG3LlzGHXOA=;
 b=lYc+zYX2kB2A7qx+7QcwmhPqrlMrDV0NtZ0gRrdXiEzPGcf1ZWK33ZG0pzsuBxuQyJ
 5p06E34meowYpzk0glRoHXI8FWzD1zOFj4sPL/1XD0WsVEfmWYVVpy2C4d1JtG8quceI
 lXMwRJ6EgFECqKtqXcwsZhP7eSKXsAYGXxG9B4/JKuX5T28soyEgsw0IhG1dJxtGAD5u
 gcECgE+biLqICHaQHKwtvqoAoF+7Aku9WXmXTa725PxH2RtsY7KwofAUDuA874aDb/UV
 87/SaE4NunZVg18FYfhDb9eeEkFHj/M9pE7CWvTR5aimYUAVzMiQ4DPJmOQJ7ulSaJlX
 2Z+Q==
X-Gm-Message-State: AJcUukfzYT1pbSewMKiiUIdJkyG2s4HtTH99WqN7TBIQVyZEbhAjTXx4
 k5uSuv/GMA0z41Xup4GFV1Qkgw==
X-Google-Smtp-Source: ALg8bN4JqMgzpBnh+Z4tFaUC666p8QU85sBklybtVotaH3zKsZdLu82eWB4V6LmtGIfb2QaLIELsPA==
X-Received: by 2002:a2e:9181:: with SMTP id f1-v6mr8948952ljg.64.1547229783489; 
 Fri, 11 Jan 2019 10:03:03 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.81.86])
 by smtp.gmail.com with ESMTPSA id a19sm13736987lfi.57.2019.01.11.10.03.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 10:03:02 -0800 (PST)
Subject: Re: [PATCH v2 03/10] usb: ehci-orion: avoid double PHY initialization
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Alan Stern <stern@rowland.harvard.edu>
References: <20190111133133.24803-1-miquel.raynal@bootlin.com>
 <20190111133133.24803-4-miquel.raynal@bootlin.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <ffb3d79a-a506-5bda-402e-98e67d52933f@cogentembedded.com>
Date: Fri, 11 Jan 2019 21:03:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190111133133.24803-4-miquel.raynal@bootlin.com>
Content-Language: en-MW
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_100306_610588_30F2FE35 
X-CRM114-Status: GOOD (  21.59  )
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
Cc: devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 linux-usb@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello!

On 01/11/2019 04:31 PM, Miquel Raynal wrote:

> No need to initialize the PHY from the driver's probe. It is done by
> the core automatically and doing it twice would increment the
> phy->powercount counter to 2 instead of 1. During later suspend
> operation, the counter will be decremented to one, no phy->power_off()
> will occur and worst than that, the following phy->power_on() at

   Worse.

> resume time will be also skipped, failing the whole S2RAM operation.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/usb/host/ehci-orion.c | 26 +++-----------------------
>  1 file changed, 3 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
> index 1ad72647a069..3109f082949e 100644
> --- a/drivers/usb/host/ehci-orion.c
> +++ b/drivers/usb/host/ehci-orion.c
> @@ -257,15 +257,7 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->phy)) {
>  		err = PTR_ERR(priv->phy);
>  		if (err != -ENOSYS)
> -			goto err_phy_get;
> -	} else {
> -		err = phy_init(priv->phy);
> -		if (err)
> -			goto err_phy_init;
> -
> -		err = phy_power_on(priv->phy);
> -		if (err)
> -			goto err_phy_power_on;
> +			goto err_dis_clk;

   Familiar code in unfamiliar place. Somebody must have blindly copied it... :-)

[...]

MBR, Sergei

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
