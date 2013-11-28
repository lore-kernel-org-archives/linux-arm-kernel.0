From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 28 Nov 2013 11:25:16 +0100
Subject: [PATCH] IMX6: Add static /8 prescaler to can_root clock
 configuration
In-Reply-To: <5EC8D4ACC923FE4D871AFFACC9761279739BE8@stwexdb.stww2k.local>
References: <5EC8D4ACC923FE4D871AFFACC9761279739BE8@stwexdb.stww2k.local>
Message-ID: <1385634316.5838.6.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Am Donnerstag, den 28.11.2013, 07:55 +0000 schrieb Belser Florian:
> Hi,
> 
> think I found a bug in the clk-imx6q.c source file. According to the reference manual the can_root clock isn't directly derived from the pll3_usb_otg clock. There is a static /8 divider instead.
> Please refer to the imx6 application reference manual:
>      i.MX 6Dual/6Quad Applications Processor Reference Manual, Rev. 0, 11/2012 --> Figure 18-3. Clock Tree - Part 2 (805)
> 
This is already fixed upstream.

> Here is the patch:
> 
If you intend to send patches in the future please generate them with
Git to make sure they have proper author information and a useful
changelog.

Regards,
Lucas

> --- linux-3.10.20/arch/arm/mach-imx/clk-imx6q.c.orig    2013-11-20 21:28:01.000000000 +0100
> +++ linux-3.10.20/arch/arm/mach-imx/clk-imx6q.c    2013-11-28 08:18:47.379521587 +0100
> @@ -424,7 +424,7 @@ int __init mx6q_clocks_init(void)
>      clk[asrc_podf]        = imx_clk_divider("asrc_podf",        "asrc_pred",         base + 0x30, 9,  3);
>      clk[spdif_pred]       = imx_clk_divider("spdif_pred",       "spdif_sel",         base + 0x30, 25, 3);
>      clk[spdif_podf]       = imx_clk_divider("spdif_podf",       "spdif_pred",        base + 0x30, 22, 3);
> -    clk[can_root]         = imx_clk_divider("can_root",         "pll3_usb_otg",      base + 0x20, 2,  6);
> +    clk[can_root]         = imx_clk_divider("can_root",         "pll3_60m",          base + 0x20, 2,  6);
>      clk[ecspi_root]       = imx_clk_divider("ecspi_root",       "pll3_60m",          base + 0x38, 19, 6);
>      clk[gpu2d_core_podf]  = imx_clk_divider("gpu2d_core_podf",  "gpu2d_core_sel",    base + 0x18, 23, 3);
>      clk[gpu3d_core_podf]  = imx_clk_divider("gpu3d_core_podf",  "gpu3d_core_sel",    base + 0x18, 26, 3);
> 
> 
> Best regards,
> 
> Florian Belser

-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
