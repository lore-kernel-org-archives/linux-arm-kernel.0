From: collinsd@codeaurora.org (David Collins)
Date: Mon, 01 Apr 2013 17:24:19 -0700
Subject: How to represent negative values for device tree property
In-Reply-To: <515A038F.2090902@wwwdotorg.org>
References: <5159F760.1080605@codeaurora.org> <515A038F.2090902@wwwdotorg.org>
Message-ID: <515A2533.8050005@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/2013 03:00 PM, Stephen Warren wrote:
> On 04/01/2013 03:08 PM, David Collins wrote:
>> Hi,
>>
>> I am working on a thermal driver which needs to be able to read a
>> temperature threshold from a device tree property.  The hardware supports
>> thresholds in the range -204.8 to +204.7 C in 0.1 C steps.  I have found,
>> as I am sure others have as well, that dtc treats a '-' before an integer
>> in a dtsi file as a syntax error.  Therefore, I need some artificial way
>> to represent negative numbers in device tree.  Here are the possibilities
>> that I have thought of so far:
> 
> Doesn't the very latest dtc, which contains integer expression support,
> allow unary -? I thought that code had been imported into the kernel
> (goes and checks) yes it has. What's the error you're seeing;
> over/underflow or syntax?
> 
> That said, DT cells are supposed to be u32 not s32, so perhaps this
> isn't unexpected.

It is likely that my dtc version is out of date.  dtc -v outputs 1.2.0.  I
will try updating to a newer version of dtc.  The error that I currently
get is a syntax error: "FATAL ERROR: Unable to parse input tree".

Does the device tree binary documentation define any format for negative
numbers?  Unsigned 32-bit integers are clearly defined as bytes in
big-endian order.  I suppose that you could assume 32-bit signed integers
are 2's complement with bytes in big-endian order, but that would need to
be well defined somewhere.

Assuming that dtb has no well defined means of holding a negative integer
value, then what is the most elegant workaround to specify a negative value?

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
