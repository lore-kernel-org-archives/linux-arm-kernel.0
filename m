From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 07 Jan 2014 22:03:11 +0100
Subject: [PATCH 1/2] ohci-platform: Add support for devicetree
 instantiation
In-Reply-To: <Pine.LNX.4.44L0.1401061043240.1282-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1401061043240.1282-100000@iolanthe.rowland.org>
Message-ID: <52CC6B8F.5000404@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/06/2014 04:49 PM, Alan Stern wrote:
> On Mon, 6 Jan 2014, Hans de Goede wrote:
>
>> Add support for ohci-platform instantiation from devicetree, including
>> optionally getting clks and a phy from devicetree, and enabling / disabling
>> those on power_on / off.
>>
>> This should allow using ohci-platform from devicetree in various cases.
>> Specifically after this commit it can be used for the ohci controller found
>> on Allwinner sunxi SoCs.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   .../devicetree/bindings/usb/platform-ohci.txt      |  25 ++++
>>   drivers/usb/host/ohci-platform.c                   | 146 ++++++++++++++++++---
>>   2 files changed, 151 insertions(+), 20 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/usb/platform-ohci.txt
>>
>> diff --git a/Documentation/devicetree/bindings/usb/platform-ohci.txt b/Documentation/devicetree/bindings/usb/platform-ohci.txt
>> new file mode 100644
>> index 0000000..6846f1c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/platform-ohci.txt
>> @@ -0,0 +1,25 @@
>> +Generic Platform OHCI controller
>> +
>> +Required properties:
>> + - compatible: Should be "platform-ohci"
>> + - reg: Address range of the ohci registers.
>> + - interrupts: Should contain the ohci interrupt.
>> +
>> +Optional properties:
>> + - clocks: array of clocks
>> + - clock-names: clock names "ahb" and/or "ohci"
>
> Where does "ahb" come from, what does it mean, and how is it relevant
> to generic platforms?

ahb is an ARM specific thing, so your right it does not belong in a
generic driver. I'll use clk1 and clk2 as names in my next version.

> What about platforms that use 3 clocks?

Ah yes I see some platforms have 3 clocks, I'll also add a clk3.

Regards,

Hans
