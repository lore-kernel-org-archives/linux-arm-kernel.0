From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Aug 2014 13:06:58 -0600
Subject: [PATCH v2 1/9] of: Add NVIDIA Tegra XUSB mailbox binding
In-Reply-To: <53FB84F7.8030509@wwwdotorg.org>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
 <1408381705-3623-2-git-send-email-abrestic@chromium.org>
 <53FB84F7.8030509@wwwdotorg.org>
Message-ID: <53FB8952.9080404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/25/2014 12:48 PM, Stephen Warren wrote:
> On 08/18/2014 11:08 AM, Andrew Bresticker wrote:
>> Add device-tree bindings for the Tegra XUSB mailbox which will be used
>> for communication between the Tegra xHCI controller's firmware and the
>> host processor.
>
>> diff --git
>> a/Documentation/devicetree/bindings/mailbox/nvidia,tegra124-xusb-mbox.txt
>> b/Documentation/devicetree/bindings/mailbox/nvidia,tegra124-xusb-mbox.txt
>
>> +NVIDIA Tegra XUSB mailbox
>> +=========================
>> +
>> +The Tegra XUSB mailbox is used by the Tegra xHCI controller's
>> firmware to
>> +communicate requests to the host and PHY drivers.
>> +
>> +Required properties:
>> +--------------------
>> + - compatible: Should be "nvidia,tegra124-xusb-mbox".
>> + - reg: Address and length of the XUSB FPCI registers.
>> + - interrupts: XUSB mailbox interrupt.
>> + - #mbox-cells: Should be 1.  The specifier is the index of the
>> mailbox to
>> +   reference.  See <dt-bindings/mailbox/tegra-xusb-mailbox.h> for the
>> list
>> +   of valid values.
>
> Is there a common mailbox binding somewhere? I couldn't find one. While
> the text above specifies the value for #mbox-cells, it doesn't specify
> the details of what the property is used for (i.e. there's no
> documentation of the consumer-side of this property, for parsing the
> mboxes property). Typically, that would be part of a subsystem's common
> binding document, and that document would be referenced here.

Ah, I see it's still being developed. I found it at:
http://lkml.iu.edu/hypermail/linux/kernel/1408.0/00201.html

It would be good to mention that the semantics of this property are 
defined by ../mailbox/mailbox.txt.
