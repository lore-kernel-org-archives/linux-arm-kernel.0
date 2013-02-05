From: rogerq@ti.com (Roger Quadros)
Date: Tue, 5 Feb 2013 10:46:51 +0200
Subject: [PATCH 04/13] mfd: omap-usb-tll: Add device tree support
In-Reply-To: <5110A0DF.7050609@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
 <1359993540-20780-5-git-send-email-rogerq@ti.com> <5110A0DF.7050609@ti.com>
Message-ID: <5110C6FB.90101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2013 08:04 AM, kishon wrote:
> On Monday 04 February 2013 09:28 PM, Roger Quadros wrote:
>> Enable this driver to probe in device tree boot.
>>
>> CC: Samuel Ortiz <sameo@linux.intel.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   .../devicetree/bindings/mfd/omap-usb-tll.txt       |   17 +++++++++++++++++
>>   drivers/mfd/omap-usb-tll.c                         |    9 +++++++++
>>   2 files changed, 26 insertions(+), 0 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt b/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
>> new file mode 100644
>> index 0000000..835cf4f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
>> @@ -0,0 +1,17 @@
>> +OMAP HS USB Host TLL (Transceiver-Less Interface)
>> +
>> +Required properties:
>> +
>> +- compatible : should be "ti,usbhs-tll"
>> +- reg : should contain one register range i.e. start and length
>> +- interrupts : should contain the TLL module's interrupt
>> +- ti,hwmod : must contain "usb_tll_hs"
>> +
>> +Example:
>> +
>> +    usbhstll: usbhstll at 0x4a062000 {
> The node name shouldn't have 0x. This comment applies to all your patches adding device tree support.

OK, will fix.

cheers,
-roger
