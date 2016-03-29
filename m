From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 29 Mar 2016 15:20:55 +0100
Subject: [PATCH 10/12] ARM: dts: dragonboard-600c: Add on board leds
 support
In-Reply-To: <20160327055012.GD8929@tuxbot>
References: <1458762366-9233-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1458762484-9768-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20160327055012.GD8929@tuxbot>
Message-ID: <56FA8F47.7070200@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Bjorn,

On 27/03/16 06:50, Bjorn Andersson wrote:
> On Wed 23 Mar 12:48 PDT 2016, Srinivas Kandagatla wrote:
>
>> This patch adds support to 4 user leds, wlan and bt led on board.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> I'm not fond of the overly complicated names; and I think it should at
> least be shortened to "db600c:...".

I agree, I will fix this in next version.

>
> Tested this on my DB600c, seems to work, except the WiFi/BT triggers,
> see comments below.
>
>> +		leds {
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&user_leds>, <&mpp_leds>;
>> +
>> +			compatible = "gpio-leds";
>> +
>> +			led at 1 {
>> +				label = "dragonboard-600c:green:user1";
>> +				gpios = <&tlmm_pinmux 3 GPIO_ACTIVE_HIGH>;
>> +				linux,default-trigger = "heartbeat";
>> +				default-state = "off";
>> +			};
>> +
>> +			led at 2 {
>> +				label = "dragonboard-600c:green:user2";
>> +				gpios = <&tlmm_pinmux 7 GPIO_ACTIVE_HIGH>;
>> +				linux,default-trigger = "mmc0";
>> +				default-state = "off";
>> +			};
>> +
>> +			led at 3 {
>> +				label = "dragonboard-600c:green:user3";
>> +				gpios = <&tlmm_pinmux 10 GPIO_ACTIVE_HIGH>;
>> +				linux,default-trigger = "mmc1";
>> +				default-state = "off";
>> +			};
>> +
>> +			led at 4 {
>> +				label = "apq8016-sbc:green:user4";
>> +				gpios = <&tlmm_pinmux 11 GPIO_ACTIVE_HIGH>;
>> +				linux,default-trigger = "none";
>> +				default-state = "off";
>> +			};
>> +
>> +			led at 5 {
>> +				label = "dragonboard-600c:yellow:wlan";
>> +				gpios = <&pm8921_mpps 7 GPIO_ACTIVE_HIGH>;
>> +				linux,default-trigger = "wlan";
>
> This should either be "phy0rx", "phy0tx", "phy0assoc" or "phy0radio". TX
> does not seem to work, so this should be debugged; "assoc" is probably
> the one that makes most sense.


Am ok, to change, did you get activity leds works with any of these 
strings with WLAN or BT?

phy0rx/tx seems to be bit more generic and atleast the name looks bit 
non-specific to wlan.

These names should be documented somewhere, Its very difficult to find 
which names to use unless you read the code.

It would be nice to just provide a phandle to the device which 
led-trigger should use, which makes it clear and explicit.



>
>> +				default-state = "off";
>> +			};
>> +
>> +			led at 6 {
>> +				label = "dragonboard-600c:blue:bt";
>> +				gpios = <&pm8921_mpps 8 GPIO_ACTIVE_HIGH>;
>> +				linux,default-trigger = "bt";
>
> This should be "hci0-power".

Does this trigger work for you?
Name is bit misleading though.

Thanks,
srini
>
>> +				default-state = "off";
>> +			};
>> +		};
>> +
>
> Regards,
> Bjorn
>
