From: leoyang.li@nxp.com (Li Yang)
Date: Mon, 27 Aug 2018 14:29:56 -0500
Subject: [PATCH 1/3] ARM: dts: Add big-endian for IFC on LS1021A
In-Reply-To: <20180817101920.20503-1-prabhakar.kushwaha@nxp.com>
References: <20180817101920.20503-1-prabhakar.kushwaha@nxp.com>
Message-ID: <CADRPPNRkJ0Hz0yyB8jKqGPn2+zq+xJa1L9Vc3_8ai06+tO7t1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 17, 2018 at 5:20 AM Prabhakar Kushwaha
<prabhakar.kushwaha@nxp.com> wrote:
>
> Register space of IFC controller is big-endian.
>
> So add big-endian in IFC device tree node.

Is this change necessary?  The current binding of IFC says:

- little-endian : If this property is absent, the big-endian mode will
                  be in use as default for registers.

>
> Signed-off-by: Alison Wang <alison.wang@nxp.com>
> Signed-off-by: Jagdish Gediya <jagdish.gediya@nxp.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index f18490548c78..1f9cae75bad3 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -1,5 +1,6 @@
>  /*
>   * Copyright 2013-2014 Freescale Semiconductor, Inc.
> + * Copyright 2018 NXP
>   *
>   * This file is dual-licensed: you can use it either under the terms
>   * of the GPL or the X11 license, at your option. Note that this dual
> @@ -154,6 +155,7 @@
>                 ifc: ifc at 1530000 {
>                         compatible = "fsl,ifc", "simple-bus";
>                         reg = <0x0 0x1530000 0x0 0x10000>;
> +                       big-endian;
>                         interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
>                 };
>
> --
> 2.14.1
>
