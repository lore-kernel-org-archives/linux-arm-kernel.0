From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Oct 2012 09:18:56 +0000
Subject: [PATCH 1/6] ARM: bcm476x: Add infrastructure
In-Reply-To: <20121007015405.958959522@gmail.com>
References: <20121007015300.828366635@gmail.com>
 <20121007015405.958959522@gmail.com>
Message-ID: <201210090918.56725.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Domenico,

Your series looks very nice, thanks for the contribution!

Stephen has already covered everything I would have commented and
more, except for one thing that I found: 

On Sunday 07 October 2012, Domenico Andreoli wrote:
> Index: b/arch/arm/boot/dts/bcm476x.dtsi
> ===================================================================
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm476x.dtsi
> @@ -0,0 +1,31 @@
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +       compatible = "brcm,bcm476x";
> +       model = "Broadcom BCM476x";
> +
> ...
> +               vic0: interrupt-controller at 80000 {
> +                       compatible = "brcm,bcm476x-pl192", "arm,pl192-vic", "arm,primecell";
> +                       reg = <0x80000 0x1000>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <1>;
> +               };

I suppose that the name of the soc is not actually "bcm476x" but you
are in fact referring to the family including bcm4760 and bcm4761.

The convention in the device tree is to always use specific product
numbers, rather than wildcards. If one of the two has a superset of
the hardware of the other, I would recommend you pick that number
in the device tree and in the drivers, and for the other one, you
just mark them as compatible to both of them.

	Arnd
