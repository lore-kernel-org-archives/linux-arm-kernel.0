From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 09 Jan 2014 20:48:14 +0100
Subject: [PATCH v3 1/2] ohci-platform: Add support for devicetree
 instantiation
In-Reply-To: <52CF0326.1090407@cogentembedded.com>
References: <1389290226-6971-1-git-send-email-hdegoede@redhat.com>
 <1389290226-6971-2-git-send-email-hdegoede@redhat.com>
 <52CF0326.1090407@cogentembedded.com>
Message-ID: <52CEFCFE.7080308@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/09/2014 09:14 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 01/09/2014 08:57 PM, Hans de Goede wrote:
>
>> Add support for ohci-platform instantiation from devicetree, including
>> optionally getting clks and a phy from devicetree, and enabling / disabling
>> those on power_on / off.
>
>> This should allow using ohci-platform from devicetree in various cases.
>> Specifically after this commit it can be used for the ohci controller found
>> on Allwinner sunxi SoCs.
>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   .../devicetree/bindings/usb/mmio-ohci.txt          |  22 +++
>>   drivers/usb/host/ohci-platform.c                   | 150 ++++++++++++++++++---
>>   2 files changed, 152 insertions(+), 20 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/usb/mmio-ohci.txt
>
>> diff --git a/Documentation/devicetree/bindings/usb/mmio-ohci.txt b/Documentation/devicetree/bindings/usb/mmio-ohci.txt
>> new file mode 100644
>> index 0000000..9c776ed
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/mmio-ohci.txt
>> @@ -0,0 +1,22 @@
>> +Generic MMIO OHCI controller
>
>     OHCI controller always uses MMIO, and likewise EHCI. You don't need to specifically mention it.

Right, I'm only using it here because it is also used in the compatible string.

>
>> +
>> +Required properties:
>> +- compatible : "mmio-ohci"
>
>     Likewise, it's not a good name. Why not call it "platform-ohci"?

Because, as you would have known had you read the entire thread, people objected
against exactly that name because the "platform" bus thing is a Linux invention,
and other operating systems don't use the platform nomenclature for non pci
busses.

Regards,

Hans
