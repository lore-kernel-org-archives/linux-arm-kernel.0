From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 7 Jun 2018 14:07:50 -0300
Subject: [PATCH 1/2] ARM: dts: imx6qdl-sabreauto: Add sensors
In-Reply-To: <b31ca3ff50566c193003614d0bbf5e0a0e95901c.1528390418.git.leonard.crestez@nxp.com>
References: <b31ca3ff50566c193003614d0bbf5e0a0e95901c.1528390418.git.leonard.crestez@nxp.com>
Message-ID: <CAOMZO5Czf1bO7vJZ1UG46DyVhzApqS82GFw+NFm_HN5tjD=xoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leonard,

On Thu, Jun 7, 2018 at 2:00 PM, Leonard Crestez <leonard.crestez@nxp.com> wrote:

> +
> +                       isl29023 at 44 {

According to Devicetree Specification v0.2 document:

"The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming model."

So you could write:

light-sensor at 44


> +                               compatible = "isil,isl29023";
> +                               reg = <0x44>;
> +                               interrupt-parent = <&gpio5>;
> +                               interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
> +                       };
> +
> +                       mag3110 at 0e {

No leading zero in unit address, please.

Building with W=1 will give you warnings about it.

magnetometer at e

> +                               compatible = "fsl,mag3110";
> +                               reg = <0x0e>;
> +                               interrupt-parent = <&gpio2>;
> +                               interrupts = <29 IRQ_TYPE_EDGE_RISING>;
> +                       };
> +
> +                       mma8451 at 1c {

accelerometer at 1c
