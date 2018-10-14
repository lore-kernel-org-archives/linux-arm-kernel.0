From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 14 Oct 2018 20:13:32 -0300
Subject: [PATCH V2 2/4] arm64: dts: imx: add imx8qxp support
In-Reply-To: <1539527419-23613-3-git-send-email-aisheng.dong@nxp.com>
References: <1539527419-23613-1-git-send-email-aisheng.dong@nxp.com>
 <1539527419-23613-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CAOMZO5BEwNQy0HA80qOzm_w-c63tFK1eL+cOHNCxKYq9PHGsqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

On Sun, Oct 14, 2018 at 11:35 AM A.s. Dong <aisheng.dong@nxp.com> wrote:
>
> Add imx8qxp support

You could probably expand the commit log by explaining a bit of what
im8qxp means.

> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> new file mode 100644
> index 0000000..e1d2578
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -0,0 +1,861 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Copyright 2017~2018 NXP

I guess you meant "-" instead of "~".

> +       memory at 80000000 {
> +               device_type = "memory";
> +               reg = <0x00000000 0x80000000 0 0x40000000>;
> +       };

This should go to the board dts file instead as the memory size may
vary from board to board.

> +               imx8qx-pm {
> +                       compatible = "fsl,scu-pd";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       pd_lsio: lsio-power-domain {
> +                               #power-domain-cells = <0>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               pd_lsio_pwm0: lsio-pwm0 at 191 {
> +                                       reg = <191>;

The number after @ is in hex, so the reg property should be 0x191.
