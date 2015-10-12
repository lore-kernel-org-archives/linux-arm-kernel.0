From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Oct 2015 14:43:04 -0700
Subject: [REPOST PATCH 1/4] ARM: dts: DRA7: Add dsp1_system syscon node
In-Reply-To: <1443828205-18706-2-git-send-email-s-anna@ti.com>
References: <1443828205-18706-1-git-send-email-s-anna@ti.com>
 <1443828205-18706-2-git-send-email-s-anna@ti.com>
Message-ID: <20151012214304.GD23801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Suman Anna <s-anna@ti.com> [151002 16:27]:
> The DSP_SYSTEM sub-module is a dedicated system control logic
> module present within a DRA7 DSP processor sub-system. This
> module is responsible for power management, clock generation
> and connection to the device PRCM module.
> 
> Add a syscon node for this module for the DSP1 processor
> sub-system. This is added as a syscon node as it is a common
> configuration module that can be used by the different IOMMU
> instances and the corresponding remoteproc device.
> 
> The node is added to the common dra7.dtsi file, as the DSP1
> processor sub-system is mostly common across all the variants
> of the DRA7 SoC family.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  arch/arm/boot/dts/dra7.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index e289c706d27d..62055094e8d5 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -292,6 +292,11 @@
>  				#thermal-sensor-cells = <1>;
>  		};
>  
> +		dsp1_system: dsp_system at 40d00000 {
> +			compatible = "syscon";
> +			reg = <0x40d00000 0x100>;
> +		};
> +
>  		sdma: dma-controller at 4a056000 {
>  			compatible = "ti,omap4430-sdma";
>  			reg = <0x4a056000 0x1000>;

Hmm so why would you want to set up a complete device as a syscon
mapping rather than just doing ioremap on it?

What drivers will be sharing access to these registers?

Regards,

Tony
