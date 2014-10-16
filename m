From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 16 Oct 2014 11:20:02 +0100
Subject: [PATCH 3/4] ARM: dts: add RK3288 suspend support
In-Reply-To: <1413406144-16329-1-git-send-email-zyw@rock-chips.com>
References: <1413405987-16196-1-git-send-email-zyw@rock-chips.com>
 <1413406144-16329-1-git-send-email-zyw@rock-chips.com>
Message-ID: <20141016102001.GA24714@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 15, 2014 at 09:49:04PM +0100, zyw at rock-chips.com wrote:
> From: Chris Zhong <zyw@rock-chips.com>
> 
> add pmu_intmem subnode for suspend, add suspend pinctrl
> 
> Signed-off-by: Tony Xie <xxx@rock-chips.com>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> ---
> 
>  arch/arm/boot/dts/rk3288.dtsi |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 5950b0a..081af7a 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -241,6 +241,11 @@
>  		status = "disabled";
>  	};
>  
> +	pmu_intmem at ff720000 {
> +		compatible = "mmio-sram", "rockchip,rk3288-pmu-sram";

These strings should be the other way around -- the most specific string
should be first.

Mark.
