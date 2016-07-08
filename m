From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Fri, 08 Jul 2016 12:17:46 +0200
Subject: [PATCH v9 1/4] dt-bindings: soc: Add documentation for the
 MediaTek GCE unit
In-Reply-To: <1467270883-1407-2-git-send-email-hs.liao@mediatek.com>
References: <1467270883-1407-1-git-send-email-hs.liao@mediatek.com>
 <1467270883-1407-2-git-send-email-hs.liao@mediatek.com>
Message-ID: <1467973066.2472.238.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Do, 2016-06-30 at 15:14 +0800, HS Liao wrote:
[...]
> +Required properties:
> +- compatible: Must be "mediatek,mt8173-gce"
> +- reg: Address range of the GCE unit
> +- interrupts: The interrupt signal from the GCE block
> +- clock: Clocks according to the common clock binding
> +- clock-names: Must be "gce" to stand for GCE clock
> +- #mbox-cells: Should be 1
[...]
> +		#mbox-cells = <1>;
[...]
> +		mediatek,gce = <&gce>;
> +		mboxes = <&gce 0 1 /* main display with merging wfe */
> +			  &gce 1 1>; /* sub display with merging wfe */

It seems that you use two cells instead of one as you declared above.
This should be consistent.

Also, why do you need an explicit phandle to the gce if you already use
mailboxes?

Best regards,
Jan L?bbe
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
