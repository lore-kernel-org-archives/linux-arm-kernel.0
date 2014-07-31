From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 31 Jul 2014 16:12:03 +0300
Subject: OMAP baseline test results for v3.16-rc4
In-Reply-To: <20140730053940.GX29045@atomide.com>
References: <alpine.DEB.2.02.1407062339420.15016@utopia.booyaka.com>
 <20140707080238.GF28884@atomide.com>
 <alpine.DEB.2.02.1407251857480.5875@utopia.booyaka.com>
 <20140729064243.GF29045@atomide.com>
 <alpine.DEB.2.02.1407290810160.22957@utopia.booyaka.com>
 <20140729084930.GH29045@atomide.com>
 <alpine.DEB.2.02.1407291225070.13035@utopia.booyaka.com>
 <alpine.DEB.2.02.1407291256270.13035@utopia.booyaka.com>
 <20140729145312.GT29045@atomide.com>
 <alpine.DEB.2.02.1407291922370.13035@utopia.booyaka.com>
 <20140730053940.GX29045@atomide.com>
Message-ID: <53DA40A3.30102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2014 08:39 AM, Tony Lindgren wrote:
> 8< -----------------------------------
> From: Tony Lindgren<tony@atomide.com>
> Date: Tue, 29 Jul 2014 22:36:59 -0700
> Subject: [PATCH] ARM: dts: Enable UART wake-up events for beagleboard
>
> For device tree based booting, we need to use wake-up
> interrupts like we already do for some omaps. This fixes
> a PM regression on beagleboard compared to legacy booting.
>
> Signed-off-by: Tony Lindgren<tony@atomide.com>
>
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -292,6 +292,7 @@
>   &uart3 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&uart3_pins>;
> +	interrupts-extended = <&intc 74 &omap3_pmx_core OMAP3_UART3_RX>;
>   };
>
>   &gpio1 {
> --

The above patch works for me with ret/off-idle on beagle rev C4 on top 
of 3.16-rc5. Without it, the board just seems to hang with ret, and with 
off, it just doesn't respond to anything on uart but seems alive otherwise.

Tested-by: Tero Kristo <t-kristo@ti.com>
