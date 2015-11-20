From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 20 Nov 2015 20:14:37 +0200
Subject: [PATCH 02/11] dt-bindings: clock: add description of LPC32xx
 USB clock controller
In-Reply-To: <20151120164133.GA9011@rob-hp-laptop>
References: <1447981511-29653-1-git-send-email-vz@mleia.com>
 <1447981511-29653-3-git-send-email-vz@mleia.com>
 <20151120164133.GA9011@rob-hp-laptop>
Message-ID: <564F630D.5090201@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.11.2015 18:41, Rob Herring wrote:
> On Fri, Nov 20, 2015 at 03:05:02AM +0200, Vladimir Zapolskiy wrote:
>> NXP LPC32xx USB controller has a subdevice, which controls USB AHB
>> slave, USB OTG, USB OHCI, USB device and I2C controller to USB phy
>> clocks, this change adds description of the clock controller, for more
>> details reference LPC32xx User's Manual, namely USB control, OTG clock
>> control and OTG clock status registers.
>>
>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>> ---
>>  .../bindings/clock/nxp,lpc3220-usb-clk.txt         | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/nxp,lpc3220-usb-clk.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/nxp,lpc3220-usb-clk.txt b/Documentation/devicetree/bindings/clock/nxp,lpc3220-usb-clk.txt
>> new file mode 100644
>> index 0000000..67fba7f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/nxp,lpc3220-usb-clk.txt
>> @@ -0,0 +1,22 @@
>> +NXP LPC32xx USB Clock Controller
>> +
>> +Required properties:
>> +- compatible: should be "nxp,lpc3220-usb-clk"
>> +- reg:  should contain clock controller registers location and length
>> +- #clock-cells: must be 1, the cell holds id of a clock provided by the
>> +  USB clock controller
>> +
>> +Examples:
>> +
>> +	usb {
> 
> I don't understand the full structure of USB blocks. Can you make the 
> example complete. All the blocks are a child of this node?

Yes, all the blocks are children of this node.

USB controller contains 5 subdevices, interestingly one of these
subdevices, I2C controller, is the same as a general purpose I2C
controller device.

Please find some description here:
http://www.spinics.net/lists/devicetree/msg98538.html

>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		compatible = "simple-bus";
>> +		ranges = <0x0 0x31020000 0x00001000>;
>> +
>> +		usbclk: clock-controller at F00 {
> lower case                               ^
> 
>> +			compatible = "nxp,lpc3220-usb-clk";
>> +			reg = <0xF00 0x100>;
> 
> lower case

Ok, thanks for pointing it out.

>> +			#clock-cells = <1>;
>> +		};
>> +	};
>> -- 
>> 2.1.4
>>

--
Vladimir
