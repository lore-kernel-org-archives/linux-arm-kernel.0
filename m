From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 29 Apr 2015 08:46:04 +0200
Subject: [PATCH v3 0/3] tty: serial: Add earlycon support to MT8173 SoC
In-Reply-To: <1430228434-31779-1-git-send-email-eddie.huang@mediatek.com>
References: <1430228434-31779-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20150429064604.GS6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 09:40:31PM +0800, Eddie Huang wrote:
> This patch add earlycon support to MT8173 SoC platform.
> To use earlycon, need
> 1. Add earlycon in boot parameters
> 2. Add "linux,sdtout-path" property in device tree file
> 
> This patch based on 4.1-rc1.
> 
> Change in v3:
> Remove noinit options, not necessary, because 8250_early.c will not init hardware
> if not provide baudrate.
> 
> Change v2:
> 1. Add noinit options.
> 2. Remove duplicate code in 8250_mtk.c, reuse the 8250_early.c existed function.
> 
> Eddie Huang (3):
>   tty: serial: 8250: export early_serial8250_setup function
>   tty: serial: 8250_mtk: Add earlycon
>   arm64: dts: Add mediatek MT8173 earlycon support

Works fine here:

Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
