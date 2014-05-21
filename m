From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 21 May 2014 08:21:45 +0200
Subject: [PATCH v2 00/20] ARM: imx: clean up i.MX5 support
In-Reply-To: <1400575538-21136-1-git-send-email-shawn.guo@freescale.com>
References: <1400575538-21136-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20140521062145.GL5858@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 04:45:18PM +0800, Shawn Guo wrote:
> i.MX51 becomes a DT only platform, so a lot of legacy code which are
> needed only by non-DT boot can be cleaned up now.  At the end of the
> day, all the static mapping and defines are removed except of a couple
> which were not defined in device tree in the first place.
> 
> Changes since v1:
>  - Address review comments from Alexander Shiyan
>  - Add more patches for a further cleanup
> 
> Shawn Guo (20):
>   ARM: imx: move EHCI platform defines out of platform_data header
>   ARM: imx5: move SOC_IMX5 and SOC_IMX51 into 'Device tree only'
>   ARM: imx5: drop option MACH_IMX51_DT
>   ARM: imx5: remove imx51 non-DT support files
>   ARM: imx5: remove i.MX5 non-DT device registration helpers
>   ARM: imx5: make mx51_clocks_init() a DT call
>   ARM: imx5: drop arguments from mx5_clocks_common_init()
>   ARM: imx5: tzic_init_irq() can directly be .init_irq hook
>   ARM: imx5: remove function imx51_soc_init()
>   ARM: imx5: call mxc_timer_init_dt() on imx51
>   ARM: imx5: retrieve iim base from device tree
>   ARM: imx5: remove header crm-regs-imx5.h
>   ARM: imx5: use dynamic mapping for CCM block
>   ARM: imx5: use dynamic mapping for DPLL block
>   ARM: imx5: reuse clock CCM mapping in pm code
>   ARM: imx5: use dynamic mapping for Cortex and GPC block
>   ARM: imx5: move init hooks into mach-imx5x.c
>   ARM: imx5: remove file mm-imx5.c
>   ARM: imx5: clean function declarations in mx51.h
>   ARM: imx5: remove mx51.h and mx53.h

This is a very nice cleanup with a nice diffstat. Thanks Shawn.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
