From: robh@kernel.org (Rob Herring)
Date: Wed, 30 Mar 2016 07:54:04 -0500
Subject: [PATCH 10/12] ARM: dts: dragonboard-600c: Add on board leds
 support
In-Reply-To: <20160327055012.GD8929@tuxbot>
References: <1458762366-9233-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1458762484-9768-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20160327055012.GD8929@tuxbot>
Message-ID: <CAL_JsqLahLTk9cjKhVct7OF7VNw7yyO-uTv6Hw-tqUSELaPm4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 27, 2016 at 12:50 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Wed 23 Mar 12:48 PDT 2016, Srinivas Kandagatla wrote:
>
>> This patch adds support to 4 user leds, wlan and bt led on board.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> I'm not fond of the overly complicated names; and I think it should at
> least be shortened to "db600c:...".

These names are exposed to userspace. They should be the same across
all 96boards. Same goes for UART numbering and I2C bus labels on the
connector.

> Tested this on my DB600c, seems to work, except the WiFi/BT triggers,
> see comments below.
>
>> +             leds {
>> +                     pinctrl-names = "default";
>> +                     pinctrl-0 = <&user_leds>, <&mpp_leds>;
>> +
>> +                     compatible = "gpio-leds";
>> +
>> +                     led at 1 {

unit-address w/o reg property will warn on new dtc. I'd suggest
something like "userX-led".


>> +                             label = "dragonboard-600c:green:user1";
>> +                             gpios = <&tlmm_pinmux 3 GPIO_ACTIVE_HIGH>;
>> +                             linux,default-trigger = "heartbeat";
>> +                             default-state = "off";
>> +                     };
