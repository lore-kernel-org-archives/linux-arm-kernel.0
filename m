From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 29 Mar 2016 07:51:15 -0700
Subject: [PATCH 10/12] ARM: dts: dragonboard-600c: Add on board leds
 support
In-Reply-To: <56FA8F47.7070200@linaro.org>
References: <1458762366-9233-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1458762484-9768-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20160327055012.GD8929@tuxbot> <56FA8F47.7070200@linaro.org>
Message-ID: <20160329145115.GO8929@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 29 Mar 07:20 PDT 2016, Srinivas Kandagatla wrote:

> Thanks Bjorn,
> 
> On 27/03/16 06:50, Bjorn Andersson wrote:
> >On Wed 23 Mar 12:48 PDT 2016, Srinivas Kandagatla wrote:
[..]
> >>+
> >>+			led at 5 {
> >>+				label = "dragonboard-600c:yellow:wlan";
> >>+				gpios = <&pm8921_mpps 7 GPIO_ACTIVE_HIGH>;
> >>+				linux,default-trigger = "wlan";
> >
> >This should either be "phy0rx", "phy0tx", "phy0assoc" or "phy0radio". TX
> >does not seem to work, so this should be debugged; "assoc" is probably
> >the one that makes most sense.
> 
> 
> Am ok, to change, did you get activity leds works with any of these strings
> with WLAN or BT?
> 

I did test them; rx, assoc and radio seems to work. Tx does not tickle
the led, but should probably.

I didn't find the spec for the baord, so I'm not sure what the LEDs
should indicate. But it feels like radio or assoc makes most sense, and
follows what we can do with the BT led.

> phy0rx/tx seems to be bit more generic and atleast the name looks bit
> non-specific to wlan.
> 
> These names should be documented somewhere, Its very difficult to find which
> names to use unless you read the code.
> 
> It would be nice to just provide a phandle to the device which led-trigger
> should use, which makes it clear and explicit.
> 

I agree, I was surprised by their naming. The phandle solution would
have been nice, except that you have no way from sysfs to pick which
node to follow.

> 
> 
> >
> >>+				default-state = "off";
> >>+			};
> >>+
> >>+			led at 6 {
> >>+				label = "dragonboard-600c:blue:bt";
> >>+				gpios = <&pm8921_mpps 8 GPIO_ACTIVE_HIGH>;
> >>+				linux,default-trigger = "bt";
> >
> >This should be "hci0-power".
> 
> Does this trigger work for you?
> Name is bit misleading though.
> 

I don't think I tested it, but it is the only bt led trigger exposed by
the bluetooth framework. I don't think we have any other hci devices on
this board, so it should be fine.

Regards,
Bjorn
