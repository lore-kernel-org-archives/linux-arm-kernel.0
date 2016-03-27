From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Sat, 26 Mar 2016 22:50:12 -0700
Subject: [PATCH 10/12] ARM: dts: dragonboard-600c: Add on board leds
 support
In-Reply-To: <1458762484-9768-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1458762366-9233-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1458762484-9768-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20160327055012.GD8929@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 23 Mar 12:48 PDT 2016, Srinivas Kandagatla wrote:

> This patch adds support to 4 user leds, wlan and bt led on board.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

I'm not fond of the overly complicated names; and I think it should at
least be shortened to "db600c:...".

Tested this on my DB600c, seems to work, except the WiFi/BT triggers,
see comments below.

> +		leds {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&user_leds>, <&mpp_leds>;
> +
> +			compatible = "gpio-leds";
> +
> +			led at 1 {
> +				label = "dragonboard-600c:green:user1";
> +				gpios = <&tlmm_pinmux 3 GPIO_ACTIVE_HIGH>;
> +				linux,default-trigger = "heartbeat";
> +				default-state = "off";
> +			};
> +
> +			led at 2 {
> +				label = "dragonboard-600c:green:user2";
> +				gpios = <&tlmm_pinmux 7 GPIO_ACTIVE_HIGH>;
> +				linux,default-trigger = "mmc0";
> +				default-state = "off";
> +			};
> +
> +			led at 3 {
> +				label = "dragonboard-600c:green:user3";
> +				gpios = <&tlmm_pinmux 10 GPIO_ACTIVE_HIGH>;
> +				linux,default-trigger = "mmc1";
> +				default-state = "off";
> +			};
> +
> +			led at 4 {
> +				label = "apq8016-sbc:green:user4";
> +				gpios = <&tlmm_pinmux 11 GPIO_ACTIVE_HIGH>;
> +				linux,default-trigger = "none";
> +				default-state = "off";
> +			};
> +
> +			led at 5 {
> +				label = "dragonboard-600c:yellow:wlan";
> +				gpios = <&pm8921_mpps 7 GPIO_ACTIVE_HIGH>;
> +				linux,default-trigger = "wlan";

This should either be "phy0rx", "phy0tx", "phy0assoc" or "phy0radio". TX
does not seem to work, so this should be debugged; "assoc" is probably
the one that makes most sense.

> +				default-state = "off";
> +			};
> +
> +			led at 6 {
> +				label = "dragonboard-600c:blue:bt";
> +				gpios = <&pm8921_mpps 8 GPIO_ACTIVE_HIGH>;
> +				linux,default-trigger = "bt";

This should be "hci0-power".

> +				default-state = "off";
> +			};
> +		};
> +

Regards,
Bjorn
