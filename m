From: olof@lixom.net (Olof Johansson)
Date: Fri, 5 Dec 2014 10:27:25 -0800
Subject: [PATCH] ARM: dts: rk3288: add arm, cpu-registers-not-fw-configured
In-Reply-To: <1416941640-324-1-git-send-email-sonnyrao@chromium.org>
References: <1416941640-324-1-git-send-email-sonnyrao@chromium.org>
Message-ID: <20141205182725.GA11755@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 10:54:00AM -0800, Sonny Rao wrote:
> This will enable use of physical arch timers on rk3288, where each
> core comes out of reset with a different virtual offset.  Using
> physical timers will help with SMP booting on coreboot and older
> u-boot and should also allow suspend-resume and cpu-hotplug to work on
> all firmwares.
> 
> Firmware which does initialize the cpu registers properly at boot and
> cpu-hotplug can remove this property from the device tree.
> 
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 0f50d5d..c861f52 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -139,6 +139,7 @@
>  
>  	timer {
>  		compatible = "arm,armv7-timer";
> +		arm,cpu-registers-not-fw-configured;
>  		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
>  			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
>  			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,

Applied, thanks.


-Olof
