From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 01 Jul 2017 18:04:26 +0200
Subject: [PATCH 1/3] arm64: dts: rockchip: add ARM Mali GPU node for rk3399
In-Reply-To: <1498913770-16519-1-git-send-email-jacob-chen@iotwrt.com>
References: <1498913770-16519-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <6356522.W9n5LLYRuo@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacob,

Am Samstag, 1. Juli 2017, 20:56:08 CEST schrieb Jacob Chen:
> Add Mali GPU device tree node for the rk3399 SoC.
> Tested with rockchip-forwardports repo.
> 
> Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 1cbd7a2..e795135 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -1443,6 +1443,18 @@
>  		status = "disabled";
>  	};
>  
> +	gpu: mali at ff9a0000 {
> +		compatible = "rockchip,rk3399-mali", "arm,mali-t860", "arm,mali-midgard";

this is missing a separate patch adding rockchip,rk3399-mali to 
	Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt

Also arm,mali-midgard is not part of the binding. I just saw that it slipped
into the example in the binding file and also the rk3288.dtsi - which should
be fixed. But the driver should bind against the arm,mali-t860 alone, not
the mali-midgard.


Heiko
