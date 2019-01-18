Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A493C5ACD3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:10:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B61D20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KT/ipObX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mSQFotD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B61D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aLK6rshvlKWi++vPfYEB3NbBhnnXKcm89DV+64rFnUA=; b=KT/ipObX25wCWX
	WTMyh/dC4buLT7YYW40GslYaL0tDLNV3s5CmKf/tODFkQu/J6bQ+R2Hv/9J+kN7VApvjGrvypdhv0
	7Tl02qZfQ/9P8m97WDgp5wrZf/emn139h/omoRc/mTLENZXWiOsAyJlRCKRl2i2mks+I/yOViuUD/
	cNuRoJvTTn7leMCYNLs+ImocaIKjaLq5VT3XbY24ibyDDOECgG/98Qtufp077PzccsEUk8CL4ra3+
	jRewRryUgvvKYhzKjlF4xJYmC827kliEw8vd1NhQkqhiQ8SnchYLzh993fmSzkahLvKFKcQFq0/nr
	YZhlrEx0qARXUnHyiZqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXfJ-0006dd-Ky; Fri, 18 Jan 2019 17:10:45 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXfH-0006dR-Il
 for linux-arm-kernel@bombadil.infradead.org; Fri, 18 Jan 2019 17:10:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
 In-Reply-To:Date:References:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PgFyL4QZ4ppPQlxcFNc2IaJXOJO7prXtOPzJnEC4UzY=; b=mSQFotD5xnFziFzKBs6hcAYfu
 gmtdcIjYA7uXkoGMqG58YnEd9YuPbPcsssaxF9vD01++Xy6pU5WP5uyGF6gSY3x8LfnbdNfQBGbPR
 NErggQbxANZefWllcjdgh3l1XQX7c7klQDBBr0BSPnWpn+yJ9eai0kOG7lVfqp6RGh2/q/vwMVHlq
 I7mSjkM7rxblCQhkZCaiheA+RFRddghUM3irTSOeWYbq8HcFrB44J59GfXu6xyoFzAb+hz18KZ0io
 0bJWnm6vzjzr9nfocd1UtQbK26dIvAgYV7sdJW1f2ifNZ+lctiUH5yIRjG01l8abbYvHcNSDjft6h
 /7W4tjQfA==;
Received: from mail.bootlin.com ([62.4.15.54])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWyg-0004Tq-8R
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:26:43 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 160942252E; Fri, 18 Jan 2019 17:26:39 +0100 (CET)
Received: from localhost (alyon-652-1-26-46.w109-213.abo.wanadoo.fr
 [109.213.9.46])
 by mail.bootlin.com (Postfix) with ESMTPSA id 2D78320C7E;
 Fri, 18 Jan 2019 17:25:31 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 03/10] usb: ehci-orion: avoid double PHY initialization
References: <20190111133133.24803-1-miquel.raynal@bootlin.com>
 <20190111133133.24803-4-miquel.raynal@bootlin.com>
Date: Fri, 18 Jan 2019 17:25:30 +0100
In-Reply-To: <20190111133133.24803-4-miquel.raynal@bootlin.com> (Miquel
 Raynal's message of "Fri, 11 Jan 2019 14:31:26 +0100")
Message-ID: <874la6lypx.fsf@FE-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_112642_533831_3B179D11 
X-CRM114-Status: GOOD (  19.94  )
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Nadav Haklai <nadavh@marvell.com>,
 Rob Herring <robh+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Miquel,
 
 On ven., janv. 11 2019, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> No need to initialize the PHY from the driver's probe. It is done by
> the core automatically and doing it twice would increment the

Do you know exactly which core take care of it?

When the phy support was added to this driver there was not such
feature. I made some research and found that recently (less than one
year ago) a series was added to initialize PHYs at HCD level[1]. I think
that our platform was forgotten in the conversion.

Could you check that we are now aligned with the requirement of this
series?

Thanks,

Gregory

[1]:https://www.spinics.net/lists/linux-usb/msg166281.html


> phy->powercount counter to 2 instead of 1. During later suspend
> operation, the counter will be decremented to one, no phy->power_off()
> will occur and worst than that, the following phy->power_on() at
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
>  
> -- 
> 2.19.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
