From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 21 Dec 2015 16:52:33 +0800
Subject: [RFC PATCH 2/5] doc: dt-binding: generic onboard USB device
In-Reply-To: <20151219041552.GA14247@rob-hp-laptop>
References: <1450431239-16439-1-git-send-email-peter.chen@freescale.com>
 <1450431239-16439-3-git-send-email-peter.chen@freescale.com>
 <20151219041552.GA14247@rob-hp-laptop>
Message-ID: <CAL411-ruqmx3qytz_Oxh6zQZZriy0Uw5+qpgpLvE4XAqwFc==Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 19, 2015 at 12:15 PM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Dec 18, 2015 at 05:33:56PM +0800, Peter Chen wrote:
>> Add dt-binding documentation for generic onboard USB device.
>
> As has already been mentioned, please following the existing USB device
> binding convention. We can debate whether the kernel driver is tied into
> existing USB drivers or separate platform drivers, but the binding needs
> to reflect the h/w.
>
> Rob
>

There is no USB device binding currently, would you mean this:
http://playground.sun.com/1275/bindings/usb/usb-1_0.ps

In fact, we hardly describe USB device at dts. No matter device address,
Device class, or compatible string, neither can work, since we know nothing
before enumeration, and there are maybe two or more usb devices at the USB bus,
only possible is {pid, vid}, but there are may be two same devices on the bus.

>>
>> Signed-off-by: Peter Chen <peter.chen@freescale.com>
>> ---
>>  .../bindings/usb/generic-onboard-device.txt        | 31 ++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/generic-onboard-device.txt
>>
>> diff --git a/Documentation/devicetree/bindings/usb/generic-onboard-device.txt b/Documentation/devicetree/bindings/usb/generic-onboard-device.txt
>> new file mode 100644
>> index 0000000..cdb3014
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/generic-onboard-device.txt
>> @@ -0,0 +1,31 @@
>> +Generic Onboard USB Device
>> +
>> +The node should be located at USB host controller's node or
>> +any USB HUB's node.
>> +
>> +Required properties:
>> +- compatible: should be "generic-onboard-device"
>> +
>> +Optional properties:
>> +- clocks: the input clock for USB device.
>> +- clock-frequency: the frequency for device's clock.
>> +- reset-gpios: Should specify the GPIO for reset.
>> +- reset-duration-us: the duration for assert reset signal, the time unit
>> +  is microsecond.
>> +
>> +Example:
>> +
>> +&usbh1 {
>> +     vbus-supply = <&reg_usb_h1_vbus>;
>> +        status = "okay";
>> +
>> +     #address-cells = <1>;
>> +     #size-cells = <0>;
>> +     hub: usb2415 at 01 {
>> +            compatible = "generic-onboard-device";
>> +            reg = <0x01>;
>> +            clocks = <&clks IMX6QDL_CLK_CKO>;
>> +            reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
>> +            reset-duration-us = <10>;
>> +     };
>> +};
>> --
>> 1.9.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
BR,
Peter Chen
