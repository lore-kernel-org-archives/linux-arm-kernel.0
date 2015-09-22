From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Sep 2015 15:34:31 +0200
Subject: [linux-sunxi] Re: [PATCH 5/5] ARM: sun5i: Add C.H.I.P DTS
In-Reply-To: <56015146.2070509@redhat.com>
References: <1442566130-3497-1-git-send-email-maxime.ripard@free-electrons.com>
 <1442566130-3497-6-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v64E-gQu1U_qi2fTWiCmfgMdMR4X6yLUerV21d3E1uQ1cw@mail.gmail.com>
 <20150922124708.GZ4684@lukather>
 <CAGb2v662+mhFgv1DXz5muA+xGE99R1DVKOxtVPvJmc+tRFPXzQ@mail.gmail.com>
 <56015146.2070509@redhat.com>
Message-ID: <560158E7.1070102@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 22-09-15 15:01, Hans de Goede wrote:
> Hi,
>
> On 22-09-15 14:57, Chen-Yu Tsai wrote:
>> On Tue, Sep 22, 2015 at 8:47 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>
> <snip>
>
>>>>> +&usb_otg {
>>>>> +       dr_mode = "otg";
>>>>> +       status = "okay";
>>>>> +};
>>>>> +
>>>>> +&usbphy {
>>>>> +       pinctrl-names = "default";
>>>>> +       pinctrl-0 = <&chip_id_det_pin>;
>>>>> +       status = "okay";
>>>>> +
>>>>> +       usb0_id_det-gpio = <&pio 6 2 GPIO_ACTIVE_HIGH>; /* PG2 */
>>>>
>>>> Better leave a comment here saying VBUS detection requires AXP209
>>>> usb-power-supply support.
>>>
>>> Does it? It can be powered by a battery, with or without VBUS, and
>>> that wouldn't be tied to the fact that the power-supply is USB or
>>> something else.
>>
>> The AXP209 VBUS / USB power-supply also doubles for VBUS detection,
>> which on most boards is done using a separate GPIO pin. Hans posted
>> support for the AXP20X power-supply driver, and support in the usb
>> phy driver using it for VBUS detection.
>
> Ack.
>
>> In short, this is not about "power supply" but VBUS detection. IIRC,
>> if no VBUS detection method is provided, the phy driver just waits a
>> period of time after an ID pin change and then considers VBUS invalid.
>
> Right, but that is a hack for boards with no / broken vbus detection
> (or vbus control), we really want to use vbus-det where available,
> so I agree that a TODO comment here would be good.

The axp209 usb-power-supply has just been merged into
linux-power-supply/next so even better we can simply update axp209.dtsi
with the node, and add do the right thing in the CHIP dts right away.

I'll send out all the dts patches which I've had queued up waiting
for this driver to get merged, including the axp209.dtsi changes.

Regards,

Hans





>
> Regards,
>
> Hans
