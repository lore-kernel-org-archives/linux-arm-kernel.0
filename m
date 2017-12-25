From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Mon, 25 Dec 2017 15:26:20 +0100
Subject: [PATCH 2/2] clk: mediatek: add audsys for MT2701 SoC
In-Reply-To: <cccf26cd2fe1f788257ff2d2b141fdaf868bf2e2.1514190088.git.ryder.lee@mediatek.com>
References: <b36f38f4b9f780529046a3c2c76a1e59561e9ff1.1514190088.git.ryder.lee@mediatek.com>
 <cccf26cd2fe1f788257ff2d2b141fdaf868bf2e2.1514190088.git.ryder.lee@mediatek.com>
Message-ID: <CAOFm3uE8b+HzjybV-9kNOnRxmCjvFQMwPcoT6EWHdGQ2m5zSug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 25, 2017 at 9:27 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> Add clock driver support for MT2701 audio subsystem.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/clk/mediatek/Kconfig          |   6 +
>  drivers/clk/mediatek/Makefile         |   1 +
>  drivers/clk/mediatek/clk-mt2701-aud.c | 204 ++++++++++++++++++++++++++++++++++
>  3 files changed, 211 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt2701-aud.c
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 59dc0aa..efb6f58 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -50,6 +50,12 @@ config COMMON_CLK_MT2701_BDPSYS
>         ---help---
>           This driver supports Mediatek MT2701 bdpsys clocks.
>
> +config COMMON_CLK_MT2701_AUDSYS
> +       bool "Clock driver for Mediatek MT2701 audsys"
> +       depends on COMMON_CLK_MT2701
> +       ---help---
> +         This driver supports Mediatek MT2701 audsys clocks.
> +
>  config COMMON_CLK_MT2712
>         bool "Clock driver for Mediatek MT2712"
>         depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index c421ffc..c4ab7d3 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_COMMON_CLK_MT6797_MMSYS) += clk-mt6797-mm.o
>  obj-$(CONFIG_COMMON_CLK_MT6797_VDECSYS) += clk-mt6797-vdec.o
>  obj-$(CONFIG_COMMON_CLK_MT6797_VENCSYS) += clk-mt6797-venc.o
>  obj-$(CONFIG_COMMON_CLK_MT2701) += clk-mt2701.o
> +obj-$(CONFIG_COMMON_CLK_MT2701_AUDSYS) += clk-mt2701-aud.o
>  obj-$(CONFIG_COMMON_CLK_MT2701_BDPSYS) += clk-mt2701-bdp.o
>  obj-$(CONFIG_COMMON_CLK_MT2701_ETHSYS) += clk-mt2701-eth.o
>  obj-$(CONFIG_COMMON_CLK_MT2701_HIFSYS) += clk-mt2701-hif.o
> diff --git a/drivers/clk/mediatek/clk-mt2701-aud.c b/drivers/clk/mediatek/clk-mt2701-aud.c
> new file mode 100644
> index 0000000..058738e
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt2701-aud.c
> @@ -0,0 +1,204 @@
> +/*
> + * Copyright (c) 2017 MediaTek Inc.
> + * Author: Ryder Lee <ryder.lee@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

Could you use SPDX tags instead of this long legalese?
-- 
Cordially
Philippe Ombredanne
