From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 12 Jul 2018 00:19:28 +0800
Subject: [PATCH v2 6/9] dt-bindings: phy: add binding for Allwinner USB3
 PHY
In-Reply-To: <20180711161356.GA4685@rob-hp-laptop>
References: <20180706153805.25842-1-icenowy@aosc.io>
 <20180706153805.25842-7-icenowy@aosc.io>
 <20180711161356.GA4685@rob-hp-laptop>
Message-ID: <C01136F1-594C-4459-B9C6-6E0434855234@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?7?12? GMT+08:00 ??12:13:56, Rob Herring <robh@kernel.org> ??:
>On Fri, Jul 06, 2018 at 11:38:02PM +0800, Icenowy Zheng wrote:
>> The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
>> external USB3 pins of the SoC.
>> 
>> Add a device tree binding for the PHY.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>> Splitted from the PHY driver patch in v1.
>> 
>>  .../bindings/phy/sun50i-usb3-phy.txt          | 24
>+++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>  create mode 100644
>Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
>> 
>> diff --git
>a/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
>b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
>> new file mode 100644
>> index 000000000000..912d55f9f69d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
>> @@ -0,0 +1,24 @@
>> +Allwinner sun50i USB3 PHY
>> +-----------------------
>> +
>> +Required properties:
>> +- compatible : should be one of
>> +  * allwinner,sun60i-h6-usb3-phy
>> +- reg : a list of offset + length pairs
>> +- #phy-cells : from the generic phy bindings, must be 0
>> +- clocks : phandle + clock specifier for the phy clock
>> +- resets : phandle + reset specifier for the phy reset
>> +
>> +Optional Properties:
>> +- phy-supply : from the generic phy bindings, a phandle to a
>regulator that
>> +	       provides power to VBUS.
>
>Power to the phy or Vbus? If the latter only, then this property should
>
>be elsewhere (like a connector node).

I don't think there's connector nodes for USB ports now.

And by checking existed device trees, use phy-supply on USB
phy is common. It's seen on Meson GXBB, RK3399 and Hi6220
in arch/arm64/boot/dts.

>
>> +
>> +Example:
>> +	usb3phy: phy at 5210000 {
>> +		compatible = "allwinner,sun50i-h6-usb3-phy";
>> +		reg = <0x5210000 0x10000>;
>> +		clocks = <&ccu CLK_USB_PHY1>;
>> +		resets = <&ccu RST_USB_PHY1>;
>> +		#phy-cells = <0>;
>> +		status = "disabled";
>> +	};
>> -- 
>> 2.17.1
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree"
>in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
