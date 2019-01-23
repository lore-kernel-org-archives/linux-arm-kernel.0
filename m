Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E50C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:02:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C0D21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mjrz8qTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C0D21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=cwUqVSbSRp4Dla29GFW0hovHvqccW8AUTH/W4JR7VRY=; b=Mjrz8qTf/88rb8
	cEHuOXo82dYcypw61fbqqDWNygLYovy41z6dW0uqq5Tafsub7LZD+JFjlvBfokMKExcHRTzMvz3uA
	ozlF0w9939fUU1eb8HLkx9wLmuXdwwlN2gNEdLVe6ap7/xPeuRaGkRyvHuoVLFeR4CSjv8H+4yy0W
	IY5BONs9OfhIRRLzR7E65pnu6HUf3ZJmdeP4bFWpVIov296FizFp/VGga8INMmXP1E39jp1WaoENP
	QFUpbYtDXEt00vt9tbue0tx7fmGZpWtn4DJRNJc3EMVrKIxEwLmRnSLr/4sRGgMs65QakNWseBAYu
	iFSql+UqfFIR/taaM7rw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmOil-0008Q3-SS; Wed, 23 Jan 2019 20:01:59 +0000
Received: from iolanthe.rowland.org ([192.131.102.54])
 by bombadil.infradead.org with smtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmOii-0008PV-V8
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 20:01:58 +0000
Received: (qmail 6293 invoked by uid 2102); 23 Jan 2019 15:01:56 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
 by localhost with SMTP; 23 Jan 2019 15:01:56 -0500
Date: Wed, 23 Jan 2019 15:01:56 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 03/10] usb: ehci-orion: avoid double PHY initialization
In-Reply-To: <20190121112336.23489-4-miquel.raynal@bootlin.com>
Message-ID: <Pine.LNX.4.44L0.1901231500300.1564-100000@iolanthe.rowland.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_120157_148574_F0142888 
X-CRM114-Status: GOOD (  17.14  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, Mathias Nyman <mathias.nyman@intel.com>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-usb@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Nadav Haklai <nadavh@marvell.com>,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 21 Jan 2019, Miquel Raynal wrote:

> No need to initialize the PHY from the driver's probe. It is done by
> the core automatically and doing it twice would increment the
> phy->powercount counter to 2 instead of 1. During later suspend
> operation, the counter will be decremented to one, no phy->power_off()
> will occur and worse than that, the following phy->power_on() at
> resume time will also be skipped, failing the whole S2RAM operation.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

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
>  	}
>  
>  	/*
> @@ -297,19 +289,12 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
>  
>  	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
>  	if (err)
> -		goto err_add_hcd;
> +		goto err_dis_clk;
>  
>  	device_wakeup_enable(hcd->self.controller);
>  	return 0;
>  
> -err_add_hcd:
> -	if (!IS_ERR(priv->phy))
> -		phy_power_off(priv->phy);
> -err_phy_power_on:
> -	if (!IS_ERR(priv->phy))
> -		phy_exit(priv->phy);
> -err_phy_init:
> -err_phy_get:
> +err_dis_clk:
>  	if (!IS_ERR(priv->clk))
>  		clk_disable_unprepare(priv->clk);
>  	usb_put_hcd(hcd);
> @@ -327,11 +312,6 @@ static int ehci_orion_drv_remove(struct platform_device *pdev)
>  
>  	usb_remove_hcd(hcd);
>  
> -	if (!IS_ERR(priv->phy)) {
> -		phy_power_off(priv->phy);
> -		phy_exit(priv->phy);
> -	}
> -
>  	if (!IS_ERR(priv->clk))
>  		clk_disable_unprepare(priv->clk);


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
