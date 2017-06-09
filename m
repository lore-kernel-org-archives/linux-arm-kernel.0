From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 9 Jun 2017 16:36:09 +0100
Subject: [linux-sunxi] Re: [PATCH v2] arm64: allwinner: a64: Add initial
 NanoPi A64 support
In-Reply-To: <3049841d-36f0-a761-fbed-57971462697c@openedev.com>
References: <1497012052-14027-1-git-send-email-jteki@openedev.com>
 <1497012052-14027-2-git-send-email-jteki@openedev.com>
 <20170609145141.aknbsis25vmy3rj6@flea.home>
 <3049841d-36f0-a761-fbed-57971462697c@openedev.com>
Message-ID: <3b4dda48-c403-88c4-5c89-63753f508d76@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/06/17 16:26, Jagan Teki wrote:
> On Friday 09 June 2017 08:21 PM, Maxime Ripard wrote:
>> Hi Jagan,
>>
>> On Fri, Jun 09, 2017 at 12:40:52PM +0000, Jagan Teki wrote:
>>> +&i2c1 {
>>> +    pinctrl-names = "default";
>>> +    pinctrl-0 = <&i2c1_pins>;
>>> +    status = "okay";
>>> +};
>>> +
>>> +&i2c1_pins {
>>> +    bias-pull-up;
>>> +};
>>
>> What is connected on that bus?
> 
> i2c1 connected with gpio/i2s

Those are the I2C pins connected to the headers. We have them in the
other A64 DTs as well (Pine64, BananaPi).
If that is not the right approach, we should discuss this and keep it
consistent at least across the A64 boards.

>>
>>> +&uart1 {
>>> +    pinctrl-names = "default";
>>> +    pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
>>> +    status = "okay";
>>> +};
>>
>> And on that UART?
> 
> uart1 for SDIO (Wifi connector, with RTS/CTS), this along with mmc1

To be precise, UART1 (with h/w handshake) is connected to the Bluetooth
part of the WiFi/BT chip, which is soldered on that board. Regardless of
the actual *WiFi* support state BT should work already - at least it did
when I tried this a few months ago on the Pine64 (although this involved
some userland heavy lifting).
Not sure what the approach here is in regard to the power supply and
wake-up GPIOs, shall they be described in this node as well or is that
up for userspace to control?

Cheers,
Andre.
