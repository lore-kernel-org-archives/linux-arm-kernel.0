From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 6 Dec 2013 16:43:10 -0500
Subject: [PATCH v2 3/5] ARM: dts: keystone: Add usb phy devicetree bindings
In-Reply-To: <20131206203003.GI21086@saruman.home>
References: <1386187811-9596-1-git-send-email-w-kwok2@ti.com>
 <1386187811-9596-4-git-send-email-w-kwok2@ti.com>
 <20131206203003.GI21086@saruman.home>
Message-ID: <52A244EE.4090301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 December 2013 03:30 PM, Felipe Balbi wrote:
> On Wed, Dec 04, 2013 at 03:10:09PM -0500, WingMan Kwok wrote:
>> Added device tree support for TI's Keystone USB PHY driver and updated the
>> Documentation with device tree binding information.
>>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
>> ---
>>  .../devicetree/bindings/usb/keystone-phy.txt       |   19 +++++++++++++++++++
>>  arch/arm/boot/dts/keystone.dtsi                    |    7 +++++++
>>  2 files changed, 26 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/keystone-phy.txt
>>
>> diff --git a/Documentation/devicetree/bindings/usb/keystone-phy.txt b/Documentation/devicetree/bindings/usb/keystone-phy.txt
>> new file mode 100644
>> index 0000000..300830d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/keystone-phy.txt
>> @@ -0,0 +1,19 @@
>> +TI Keystone USB PHY
>> +
>> +Required properties:
>> + - compatible: should be "ti,keystone-usbphy".
>> + - #address-cells, #size-cells : should be '1' if the device has sub-nodes
>> +   with 'reg' property.
>> + - reg : Address and length of the usb phy control register set.
>> +
>> +The main purpose of this PHY driver is to enable the USB PHY reference clock
>> +gate on the Keystone SOC for both the USB2 and USB3 PHY. Otherwise it is just
>> +an NOP PHY driver.  Hence this node is referenced as both the usb2 and usb3
>> +phy node in the USB Glue layer driver node.
>> +
>> +usb_phy: usb_phy at 2620738 {
>> +	compatible = "ti,keystone-usbphy";
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +	reg = <0x2620738 32>;
>> +};
>> diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
>> index f6d6d9e..d497d9e 100644
>> --- a/arch/arm/boot/dts/keystone.dtsi
>> +++ b/arch/arm/boot/dts/keystone.dtsi
>> @@ -181,5 +181,12 @@
>>  			interrupts = <GIC_SPI 300 IRQ_TYPE_EDGE_RISING>;
>>  			clocks = <&clkspi>;
>>  		};
>> +
>> +		usb_phy: usb_phy at 2620738 {
>> +			compatible = "ti,keystone-usbphy";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			reg = <0x2620738 32>;
> 
> should this one have status = "disabled"; and let board dts enable the
> PHY ?
> 
Currently there is only one board but probably not a bad idea to enable
it from board dts. Lets do that

Regards,
Santosh 
