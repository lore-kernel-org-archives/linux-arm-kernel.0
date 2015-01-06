From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 06 Jan 2015 18:44:13 +0100
Subject: [PATCH v3 3/3] ARM: dts: Specify VMMC and VQMMC on rk3288-evb
In-Reply-To: <1418689340-29517-3-git-send-email-dianders@chromium.org>
References: <1418689340-29517-1-git-send-email-dianders@chromium.org>
 <1418689340-29517-3-git-send-email-dianders@chromium.org>
Message-ID: <1798568.RumoICfKOO@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

Am Montag, 15. Dezember 2014, 16:22:20 schrieb Doug Anderson:
> Specifying these rails should eventually let us do UHS.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
> Changes in v3: None
> Changes in v2:
> - Fix subject line
> 
>  arch/arm/boot/dts/rk3288-evb.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi
> b/arch/arm/boot/dts/rk3288-evb.dtsi index 3e067dd..d660fe6 100644
> --- a/arch/arm/boot/dts/rk3288-evb.dtsi
> +++ b/arch/arm/boot/dts/rk3288-evb.dtsi
> @@ -114,6 +114,8 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
>  	status = "okay";
> +	vmmc-supply = <&vcc_io>;

according to the schematics there is a switch between the card and vcc_io with 
a controlling pin called SDMMC_PWR providing a supply called vcc_sd.

So there should probably be a fixed-regulator get introduced for this, like the 
older rockchip boards do.


Heiko
