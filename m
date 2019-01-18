Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2582DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:04:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57602086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aGvwSsLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57602086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uAUfeGnlBw1mkcm2KOsgHZxxDhFkjnvX5PiXSBW4xOg=; b=aGvwSsLQC+YGuT
	DQ26TQLEmUtN0HTBQlguY8hYOZ8mAj9GyGmKM6sf2yaVPyyyL8BZWG1N7USB/2etffCb8bwKCr7RM
	MiGYcqd0k9A71GPXuyhnwAOTnhD81Dyty2dVXzKJEao3/VqDkGxFGTXBZqvLV0+tRnWuJcmYJax4A
	aMeifV2h/PQeADaXJh/fEygixB4AF/VuKXVh1/N+NaJXNE6A9pkhQ7p3AlqaVAyjo/fXlBmLXyHz0
	wtV2l2EE8s5lnyWY0f6spnYVxpLM/4lD0darS4NXDPXjCFtgYftyr5ZYkeo7F1e15BJ2YTPsWO9iA
	2lS9pdTMMKAWwwu26d2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWd2-00082o-4K; Fri, 18 Jan 2019 16:04:20 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWcx-00082U-NR
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:04:18 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 4FEF22074A; Fri, 18 Jan 2019 17:04:14 +0100 (CET)
Received: from localhost (alyon-652-1-26-46.w109-213.abo.wanadoo.fr
 [109.213.9.46])
 by mail.bootlin.com (Postfix) with ESMTPSA id 48AAE206A7;
 Fri, 18 Jan 2019 17:04:03 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 02/10] usb: host: xhci: mvebu: add reset on resume quirk
References: <20190111133133.24803-1-miquel.raynal@bootlin.com>
 <20190111133133.24803-3-miquel.raynal@bootlin.com>
Date: Fri, 18 Jan 2019 17:04:01 +0100
In-Reply-To: <20190111133133.24803-3-miquel.raynal@bootlin.com> (Miquel
 Raynal's message of "Fri, 11 Jan 2019 14:31:25 +0100")
Message-ID: <878szilzpq.fsf@FE-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_080416_036615_C9D69468 
X-CRM114-Status: GOOD (  26.22  )
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
 Ofer Heifetz <oferh@marvell.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Miquel,
 
 On ven., janv. 11 2019, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> From: Ofer Heifetz <oferh@marvell.com>
>
> The mvebu xHCI host driver does not have suspend/resume support. Use of
> the XHCI_RESET_ON_RESUME quirk is mandatory in order to avoid failures
> after resume. This will work only if no USB device is plugged-in.
>
> While at it, mention in the Kconfig file that this IP is also present
> on the A3700 SoC.
>
> Signed-off-by: Ofer Heifetz <oferh@marvell.com>
> [miquel.raynal@bootlin.com: Reword the commit message]
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/usb/host/Kconfig      |  4 ++--
>  drivers/usb/host/xhci-mvebu.c | 11 +++++++++++
>  drivers/usb/host/xhci-mvebu.h |  6 ++++++
>  drivers/usb/host/xhci-plat.c  |  7 +++++++
>  4 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 16758b12a5e9..13d59be6a6aa 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -69,13 +69,13 @@ config USB_XHCI_MTK
>  	  If unsure, say N.
>  
>  config USB_XHCI_MVEBU
> -	tristate "xHCI support for Marvell Armada 375/38x"
> +	tristate "xHCI support for Marvell Armada 375/38x/3700"

I would name it 37xx to be consistent with 38x

>  	select USB_XHCI_PLATFORM
>  	depends on HAS_IOMEM
>  	depends on ARCH_MVEBU || COMPILE_TEST
>  	---help---
>  	  Say 'Y' to enable the support for the xHCI host controller
> -	  found in Marvell Armada 375/38x ARM SOCs.
> +	  found in Marvell Armada 375/38x/3700 ARM SOCs.
same here


>  
>  config USB_XHCI_RCAR
>  	tristate "xHCI support for Renesas R-Car SoCs"
> diff --git a/drivers/usb/host/xhci-mvebu.c b/drivers/usb/host/xhci-mvebu.c
> index 32e158568788..60651a50770f 100644
> --- a/drivers/usb/host/xhci-mvebu.c
> +++ b/drivers/usb/host/xhci-mvebu.c
> @@ -13,6 +13,7 @@
>  #include <linux/usb/hcd.h>
>  
>  #include "xhci-mvebu.h"
> +#include "xhci.h"
>  
>  #define USB3_MAX_WINDOWS	4
>  #define USB3_WIN_CTRL(w)	(0x0 + ((w) * 8))
> @@ -72,3 +73,13 @@ int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd)
>  
>  	return 0;
>  }
> +
> +int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd)
> +{
> +	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> +
> +	/* Without reset on resume, the HC won't work at all */
> +	xhci->quirks |= XHCI_RESET_ON_RESUME;
> +
> +	return 0;
> +}
> diff --git a/drivers/usb/host/xhci-mvebu.h b/drivers/usb/host/xhci-mvebu.h
> index 09791df2cec0..ca0a3a5721dd 100644
> --- a/drivers/usb/host/xhci-mvebu.h
> +++ b/drivers/usb/host/xhci-mvebu.h
> @@ -12,10 +12,16 @@ struct usb_hcd;
>  
>  #if IS_ENABLED(CONFIG_USB_XHCI_MVEBU)
>  int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd);
> +int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd);
>  #else
>  static inline int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd)
>  {
>  	return 0;
>  }
> +
> +static inline int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd)
> +{
> +	return 0;
> +}
>  #endif
>  #endif /* __LINUX_XHCI_MVEBU_H */
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index ef09cb06212f..0ac4ec975547 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -98,6 +98,10 @@ static const struct xhci_plat_priv xhci_plat_marvell_armada = {
>  	.init_quirk = xhci_mvebu_mbus_init_quirk,
>  };
>  
> +static const struct xhci_plat_priv xhci_plat_marvell_armada3700 = {
> +	.init_quirk = xhci_mvebu_a3700_init_quirk,
> +};
> +
>  static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen2 = {
>  	.firmware_name = XHCI_RCAR_FIRMWARE_NAME_V1,
>  	.init_quirk = xhci_rcar_init_quirk,
> @@ -123,6 +127,9 @@ static const struct of_device_id usb_xhci_of_match[] = {
>  	}, {
>  		.compatible = "marvell,armada-380-xhci",
>  		.data = &xhci_plat_marvell_armada,
> +	}, {
> +		.compatible = "marvell,armada3700-xhci",
> +		.data = &xhci_plat_marvell_armada3700,


Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
