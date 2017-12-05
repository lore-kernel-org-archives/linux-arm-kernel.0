From: k@japko.eu (Krzysztof Adamski)
Date: Tue, 5 Dec 2017 23:10:16 +0100
Subject: [PATCH] ARM: dts: sun8i: h3: enable USB OTG for NanoPi Neo board
In-Reply-To: <20171205090706.et5a7dizkhn6auje@flea.lan>
References: <20171201224942.GA12473@t440.localdomain>
 <20171205090706.et5a7dizkhn6auje@flea.lan>
Message-ID: <20171205221016.GA16666@t440.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 05, 2017 at 10:07:06AM +0100, Maxime Ripard wrote:
>> diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
>> index 78f6c24952dd..14c3f137dbd3 100644
>> --- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
>> +++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
>> @@ -53,3 +53,20 @@
>> 	allwinner,leds-active-low;
>> 	status = "okay";
>> };
>> +
>> +&usb_otg {
>> +	status = "okay";
>> +	dr_mode = "peripheral";
>> +};
>> +
>> +&usbphy {
>> +	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
>> +};
>> +
>> +&ohci0 {
>> +	status = "okay";
>> +};
>> +
>> +&ehci0 {
>> +	status = "okay";
>> +};
>
>Please sort the nodes in alphabetical order.

Will do in v2 sent in separate e-mail.

>Also, does it make sense to add the OHCI and EHCI controller for a
>peripheral-only device?

It does. The reasoning is the same as for the OrangePi Zero board in the
patch by Icenowy Zheng (72897fa31fcf6222a11c6ebb0bcca25628bb1f7c) - the
host mode on this board should work if you have external power source.
In this case you can switch the mode via sysfs. I wanted to be
consistent with the approach taken for the OrangePi Zero board. I added
this reasoning to the commit message of v2.

Best regards,
Krzysztof Adamski
