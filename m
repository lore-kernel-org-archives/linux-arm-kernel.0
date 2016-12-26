From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 26 Dec 2016 12:13:22 +0100
Subject: [PATCH v3 2/4] dt-bindings: add bindings for rk3328 clock
 controller
In-Reply-To: <1482723930-5876-3-git-send-email-zhangqing@rock-chips.com>
References: <1482723930-5876-1-git-send-email-zhangqing@rock-chips.com>
 <1482723930-5876-3-git-send-email-zhangqing@rock-chips.com>
Message-ID: <74138347.WHV1Wnrpph@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Elaine,

Am Montag, 26. Dezember 2016, 11:45:28 CET schrieb Elaine Zhang:
> Add devicetree bindings for Rockchip cru which found on
> Rockchip SoCs.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/clock/rockchip,rk3328-cru.txt         | 57
> ++++++++++++++++++++++ 1 file changed, 57 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.txt
> b/Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.txt new file
> mode 100644
> index 000000000000..20053494d49f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.txt
> @@ -0,0 +1,57 @@
> +* Rockchip RK3328 Clock and Reset Unit
> +
> +The RK3328 clock controller generates and supplies clock to various
> +controllers within the SoC and also implements a reset controller for SoC
> +peripherals.
> +
> +Required Properties:
> +
> +- compatible: should be "rockchip,rk3328-cru"
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- #clock-cells: should be 1.
> +- #reset-cells: should be 1.
> +
> +Optional Properties:
> +
> +- rockchip,grf: phandle to the syscon managing the "general register files"
> +  If missing pll rates are not changeable, due to the missing pll lock
> status. +
> +Each clock is assigned an identifier and client nodes can use this
> identifier +to specify the clock which they consume. All available clocks
> are defined as +preprocessor macros in the dt-bindings/clock/rk3328-cru.h
> headers and can be +used in device tree sources. Similar macros exist for
> the reset sources in +these files.
> +
> +External clocks:
> +
> +There are several clocks that are generated outside the SoC. It is expected
> +that they are defined using standard clock bindings with following
> +clock-output-names:
> + - "xin24m" - crystal input - required,
> + - "clkin_i2s" - external I2S clock - optional,
> + - "gmac_clkin" - external GMAC clock - optional
> + - "phy_50m_out" - output clock of the pll in the mac phy
> +
> +Example: Clock controller node:
> +
> +	cru: clock-controller at ff440000 {
> +		compatible = "rockchip,rk3328-cru", "rockchip,cru", "syscon";

Rob suggested dropping the "rockchip,cru" and "syscon" properties from the 
example and I definitly agree with that.

Otherwise look ok to me.


Heiko
