From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 09 May 2014 14:39:17 +0200
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun6i-a31-app4-evb1.dts:
 Use sunxi-common-regulators.dtsi
In-Reply-To: <536CA092.50300@free-electrons.com>
References: <1399624987-12381-1-git-send-email-hdegoede@redhat.com>
 <536C97FD.3070906@free-electrons.com> <536C9A53.2060302@redhat.com>
 <536CA092.50300@free-electrons.com>
Message-ID: <536CCC75.7050407@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/09/2014 11:32 AM, Boris BREZILLON wrote:
> 
> On 09/05/2014 11:05, Hans de Goede wrote:
>> Hi,
>>
>> On 05/09/2014 10:55 AM, Boris BREZILLON wrote:
>>> On 09/05/2014 10:43, Hans de Goede wrote:
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>  arch/arm/boot/dts/sun6i-a31-app4-evb1.dts | 8 +-------
>>>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
>>>> index 270ab97..2bbf886 100644
>>>> --- a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
>>>> +++ b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
>>>> @@ -13,6 +13,7 @@
>>>>  
>>>>  /dts-v1/;
>>>>  /include/ "sun6i-a31.dtsi"
>>>> +/include/ "sunxi-common-regulators.dtsi"
>>>>  
>>>>  / {
>>>>  	model = "Allwinner A31 APP4 EVB1 Evaluation Board";
>>>> @@ -49,15 +50,8 @@
>>>>  	};
>>>>  
>>>>  	reg_usb1_vbus: usb1-vbus {
>>>> -		compatible = "regulator-fixed";
>>>> -		pinctrl-names = "default";
>>>>  		pinctrl-0 = <&usb1_vbus_pin_a>;
>>>> -		regulator-name = "usb1-vbus";
>>>> -		regulator-min-microvolt = <5000000>;
>>>> -		regulator-max-microvolt = <5000000>;
>>>> -		enable-active-high;
>>>>  		gpio = <&pio 7 27 0>;
>>>>  		status = "okay";
>>>>  	};
>>> I guess we could do the same for usb1_vbus_pin_a (keep the common
>>> definition and change the allwinner,pins property).
>> Hmm, what we do with other boards when the pin does not match the
>> default is change the node name to something baord specific, ie
>> usb1_vbus_pin_app4_evb1
> 
> Okay.
> How did you decide which pins should be put in the default definitions
> (the most used ones among available boards ?) ?

The pins used there are used on all-most all A10 and A20 boards,
the sun5i (A10s / A13) boards seem to not really have any standard gpio
they use, and I have not seen enough A31 boards yet to say anything sensible.

We may need to rename the standard pins to include the platform name if
A31 also uses the same pin everywhere (but a different one from A10).

> I'm not sure defining new pin states for each board is a good solution,
> because you'll embed unneeded pin states in your DTB.
> Anyway, this is your call :-).
> 
>> Which is why I did not remove the common bits from the pin,
>> I did not notice you did not use a board specific name here.
> 
> Then I guess it should be fixed in the same series.
> BTW, AFAIK the original patch adding support for the APP4 EVB1 board has
> not been applied yet, so I think we can fix it send a v2 of this patch.

It is already in Maxime's dt-for-3.16 tree, so it is probably better to fix
this with a followup patch.

Regards,

Hans
