From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 22 May 2018 21:34:16 +0200
Subject: [PATCH 2/2] ARM: pxa: dts: add pin definitions for extended GPIOs
In-Reply-To: <20180521220044.821-2-daniel@zonque.org> (Daniel Mack's message
 of "Tue, 22 May 2018 00:00:44 +0200")
References: <20180521220044.821-1-daniel@zonque.org>
 <20180521220044.821-2-daniel@zonque.org>
Message-ID: <87tvqzxz5z.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> The PXA3xx series features some extended GPIO banks which are named GPIO0_2,
> GPIO1_2 etc. The PXA300, PXA310 and PXA320 have different numbers of such
> pins, and they also have variant-specific register offsets.
>
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
>  arch/arm/boot/dts/pxa3xx.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
> index a13ac52e4fd2..446e612688c0 100644
> --- a/arch/arm/boot/dts/pxa3xx.dtsi
> +++ b/arch/arm/boot/dts/pxa3xx.dtsi
> @@ -8,6 +8,13 @@
>  	 (gpio <= 98) ? (0x0400 + 4 * (gpio - 27)) :	\
>  	 (gpio <= 127) ? (0x0600 + 4 * (gpio - 99)) :	\
>  	 0)
> +#define MFP_PIN_PXA300_0_2	0x674
> +#define MFP_PIN_PXA300_1_2	0x678
> +#define MFP_PIN_PXA300_2_2	0x2dc
> +#define MFP_PIN_PXA300_3_2	0x2e0
> +#define MFP_PIN_PXA300_4_2	0x2e4
> +#define MFP_PIN_PXA300_5_2	0x2e8
> +#define MFP_PIN_PXA300_6_2	0x2ec

To be consistent with the previous items, could it be something like :
#define MFP_PIN_PXA300_2(gpio) \
  ... etc ...

And so on for the others.

Cheers.

-- 
Robert
