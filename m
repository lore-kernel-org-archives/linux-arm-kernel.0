From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 18 Sep 2014 07:07:40 +0200
Subject: [PATCH 1/2] devicetree: cadence_ttc: Document binding for timer
 width
In-Reply-To: <20140917161737.GA7983@leverpostej>
References: <3537996136ec435ea660da869102d0a019214979.1410964243.git.michal.simek@xilinx.com>
 <20140917161737.GA7983@leverpostej>
Message-ID: <db43281a-06bc-436b-a082-212d1f95d974@BL2FFO11FD034.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2014 06:17 PM, Mark Rutland wrote:
> On Wed, Sep 17, 2014 at 03:30:49PM +0100, Michal Simek wrote:
>> From: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
>>
>> Modern TTC implementations can extend the timer width to 32 bit. This
>> feature is not self identifying so the driver needs to be made aware
>> via device tree.
>>
>> Signed-off-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt b/Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt
>> index 993695c659e1..5439976eca6b 100644
>> --- a/Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt
>> +++ b/Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt
>> @@ -6,6 +6,9 @@ Required properties:
>>  - interrupts : A list of 3 interrupts; one per timer channel.
>>  - clocks: phandle to the source clock
>>
>> +Optional properties:
>> +- timer-width: Bit width of the timer. Either 16 or 32 (default 16).
> 
> Are we expecting TTC implementations with widths other than 16 or 32?

IRC if you use 32bit timer and setup for example 24bit width it should work
too and you are just ignoring that upper bits.

> 
> This looks sane to me, but we might be able to just have a 32-bit-timer
> property if we don't expect arbitrary widths.

Definitely model different timer width is easily possible to do in qemu
that's why I think having more generic property timer-width is just better than
having property used just for one case.

Thanks,
Michal


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140918/3e67cb67/attachment-0001.sig>
