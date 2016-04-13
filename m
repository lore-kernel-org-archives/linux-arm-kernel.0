From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Apr 2016 12:48:04 -0700
Subject: [PATCH 31/47] ARM: dts: r8a7794: Reference both DMA controllers
 in SCIFA nodes
In-Reply-To: <65c295f4b305330162795b0cc2508a207ed23a98.1459732726.git.horms+renesas@verge.net.au>
References: <cover.1459732726.git.horms+renesas@verge.net.au>
 <65c295f4b305330162795b0cc2508a207ed23a98.1459732726.git.horms+renesas@verge.net.au>
Message-ID: <CAOesGMgBBmUvoWdb35vcq0UAJNkMk5LD6-ERWDAaSKWEpGwu9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Commenting on this random patch in the series, but I'm guessing the
same applies for others.

First, I think it's somewhat silly to split this up into 31 patches
instead of just doing one. But it's not bad enough that it really
matters.

My bigger concern is:


On Sun, Apr 3, 2016 at 6:23 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
> index eacb2b291361..4256557ca041 100644
> --- a/arch/arm/boot/dts/r8a7794.dtsi
> +++ b/arch/arm/boot/dts/r8a7794.dtsi
> @@ -296,8 +296,9 @@
>                 interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
>                 clocks = <&mstp2_clks R8A7794_CLK_SCIFA0>;
>                 clock-names = "fck";
> -               dmas = <&dmac0 0x21>, <&dmac0 0x22>;
> -               dma-names = "tx", "rx";
> +               dmas = <&dmac0 0x21>, <&dmac0 0x22>,
> +                      <&dmac1 0x21>, <&dmac1 0x22>;
> +               dma-names = "tx", "rx", "tx", "rx";
>                 power-domains = <&cpg_clocks>;
>                 status = "disabled";
>         };

The names are no longer unique. So a get_<foo>_by_name() function no
longer can work as expected.

This should be fixed.

-Olof
