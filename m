Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A8DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 20:40:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E195621783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 20:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G03D+S+I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTYR1Zxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E195621783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V3vZPpEOZyTY931WA/8uH7pbkeWaqQ+oOtlOV5Madew=; b=G03D+S+IqBIiTV
	vGGYptXa9dsVzDNzo9UC1V1crBOtm5L1YtNbKQ3BWGhthaPjavZ+ymdk49BBTrLSFVu5AvfEZWgD/
	gbz/1IUXW/qAhjhm/tp8/PzXUMcRNXFjfC26xes1kskS8EfRufre0aM3xTji7LrLdVU4kAuJJHrIi
	RJ8s0WLatqp0qBZ7SBCgaGwBEx2Bc/LnAA+Z4WrIgefnhW7MOt3FjtKw9921rVrxcaQeWM8oMs6EN
	JZCiReF6jA1XZC2lD/F+GNB/dgYwL5DvsBzsK/Q/6mdodu5Nri5Ty9jK9Du4Jt7aPeNSeBMoCSPCf
	lqnwDwDU/1sR9S025btw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge4Mo-0006oM-M6; Mon, 31 Dec 2018 20:40:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge4Ml-0006o1-Ss
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 20:40:53 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9CFF921019;
 Mon, 31 Dec 2018 20:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546288850;
 bh=bXn5PAxPmJETDf7IGQcCLV2q8CDe7Qpa3PLg0V7bzS8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aTYR1Zxi26Rp+SN7/3G2m+gYVKwErVNsjVHpWFL5sTx5WxMR6Mon/ZJGs/ZtmozxZ
 mw6+Iu9qEh6oz93zYpsX3T2eqRkrdyJMyrUWMNQHMrfhqCTSsAVRmMbQreg4gr9N4d
 4l7OSzdzo9BflPdNxunHwPtSpk+kPjN/aKjPTUFc=
Date: Mon, 31 Dec 2018 14:40:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH] pci: dwc: add a check for resetting gpio
Message-ID: <20181231204048.GG159477@google.com>
References: <20181226022236.71682-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181226022236.71682-1-kjlu@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_124051_955504_DD28B3B8 
X-CRM114-Status: GOOD (  16.67  )
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
Cc: linux-samsung-soc@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
 pakki001@umn.edu, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Kukjin Kim <kgene@kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kangjie,

Thanks for the patch.

On Tue, Dec 25, 2018 at 08:22:36PM -0600, Kangjie Lu wrote:
> devm_gpio_request_one() could fail. The fix checks its status and issues
> an error if it fails.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/pci/controller/dwc/pci-exynos.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index cee5f2f590e2..e3a045e215d2 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -226,9 +226,12 @@ static void exynos_pcie_assert_reset(struct exynos_pcie *ep)
>  	struct dw_pcie *pci = ep->pci;
>  	struct device *dev = pci->dev;
>  
> -	if (ep->reset_gpio >= 0)
> -		devm_gpio_request_one(dev, ep->reset_gpio,
> -				GPIOF_OUT_INIT_HIGH, "RESET");
> +	if (ep->reset_gpio >= 0) {
> +		if (devm_gpio_request_one(dev, ep->reset_gpio,
> +				GPIOF_OUT_INIT_HIGH, "RESET"))
> +			dev_err(dev, "Failed requesting reset gpio %d\n",
> +					ep->reset_gpio);
> +	}

Even before your patch, this code doesn't make sense to me.

devm_gpio_request_one() is a setup function and should be called in
the probe path.  The "assert_reset" path should do something like
gpio_set_value().  See other callers, e.g.,

  imx6_pcie_probe()
  histb_pcie_probe()
  mvebu_pcie_parse_port()

I'm skeptical that exynos_pcie_assert_reset() ever worked as intended,
so let's straighten that out before worrying about checking the return
code from devm_gpio_request_one().

The result should be two patches: (1) fix the devm_gpio_request_one()
usage, and (2) check the devm_gpio_request_one() return value.

>  }

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
