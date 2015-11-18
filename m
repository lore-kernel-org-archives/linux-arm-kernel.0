From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 18 Nov 2015 10:00:50 -0200
Subject: [PATCH 2/2] ARM: dts: imx6q: add Novena board
In-Reply-To: <1447840120-8513-2-git-send-email-marex@denx.de>
References: <1447840120-8513-1-git-send-email-marex@denx.de>
 <1447840120-8513-2-git-send-email-marex@denx.de>
Message-ID: <CAOMZO5C1oYge+TUKPYsgBRV75HVDwj42oAo27aaK-XqtHw8-7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Wed, Nov 18, 2015 at 7:48 AM, Marek Vasut <marex@denx.de> wrote:

> +++ b/arch/arm/boot/dts/imx6q-novena.dts
> @@ -0,0 +1,825 @@
> +/*
> + * Copyright 2014 Sutajio Ko-Usagi PTE LTD
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + * Copyright 2011 Linaro Ltd.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html

Could you make this GPL/X11 dual-license?

Take a look at arch/arm/boot/dts/imx6qdl-cubox-i.dtsi for a reference.

> +&iomuxc {
> +       audmux {
> +               pinctrl_audmux_novena: audmuxgrp-novena {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_CSI0_DAT7__AUD3_RXD  0x80000000
> +                               MX6QDL_PAD_CSI0_DAT4__AUD3_TXC  0x80000000
> +                               MX6QDL_PAD_CSI0_DAT5__AUD3_TXD  0x80000000
> +                               MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS 0x80000000

Please avoid these 0x80000000 throughout this file.

We should better not rely on the IOMUX settings done in the bootloader.

Regards,

Fabio Estevam
