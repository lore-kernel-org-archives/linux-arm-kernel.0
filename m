From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 28 Feb 2017 23:00:25 +0100
Subject: [PATCH v2 4/6] arm64: dts: rockchip: add Gru/Kevin DTS
In-Reply-To: <20170210010521.78872-5-briannorris@chromium.org>
References: <20170210010521.78872-1-briannorris@chromium.org>
 <20170210010521.78872-5-briannorris@chromium.org>
Message-ID: <6978416.eyJmBK6ozI@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

Am Donnerstag, 9. Februar 2017, 17:05:19 CET schrieb Brian Norris:
> Kevin is part of a family of boards called Gru. As best as possible, the
> properties shared by the Gru family are placed in rk3399-gru.dtsi, while
> Kevin-specific bits are in rk3399-gru-kevin.dts. This does not add full
> support for the base Gru board.
> 

short summary of what we just talked about, and some more minor things I found

[...]

> +	/* pp3300 children */

drop that. I may not have caught all of them, but you get the idea ;-)


> +	pp3300_wifi_bt: pp3300-wifi-bt {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp3300_wifi_bt";
> +		/* NOTE: wlan_module_pd_l pinctrl in pp1800_pcie */
> +
> +		enable-active-high;
> +
> +		/* NOTE: this GPIO also used in pp1800_pcie */

does the gpio subsystem like this double usage?

> +		gpio = <&gpio0 4 GPIO_ACTIVE_HIGH>;
> +
> +		vin-supply = <&pp3300>;
> +	};
> +
> +	/* pp5000 aliases; these are always on for AP so just use alias */

drop that

> +
> +	/* EC turns on w/ usb_a_en */
> +	pp5000_usb_a_vbus: pp5000 {
> +	};
> +
> +	/* END REGULATORS */

drop that

> +
> +	io-domains {

&io_domains instead

> +		compatible = "rockchip,rk3399-io-voltage-domain";
> +		rockchip,grf = <&grf>;
> +
> +		bt656-supply = <&pp1800_ap_io>;		/* APIO2_VDD;  2a 2b */
> +		audio-supply = <&pp1800_audio>;		/* APIO5_VDD;  3d 4a */
> +		sdmmc-supply = <&ppvar_sd_card_io>;	/* SDMMC0_VDD; 4b    */
> +		gpio1830-supply = <&pp3000_ap>;		/* APIO4_VDD;  4c 4d */
> +	};


> +	pmu-io-domains {

&pmu_io_domains instead

> +		compatible = "rockchip,rk3399-pmu-io-voltage-domain";
> +		rockchip,grf = <&pmugrf>;
> +
> +		pmu1830-supply = <&pp1800_pmu>;		/* PMUIO2_VDD */
> +	};


> +#include "common/cros-ec-keyboard.dtsi"
> +#include "common/cros-ec-sbs.dtsi"

please try the arm include symlinks instead


> +
> +/* PINCTRL: always below everything else */
> +

 drop this

> +
> +/* DON'T PUT ANYTHING BELOW HERE.  PUT IT ABOVE PINCTRL */
> +/* DON'T PUT ANYTHING BELOW HERE.  PUT IT ABOVE PINCTRL */
> +/* DON'T PUT ANYTHING BELOW HERE.  PUT IT ABOVE PINCTRL */
> +

drop these


Heiko
