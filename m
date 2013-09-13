From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Sep 2013 15:51:56 -0500
Subject: [PATCH 1/2] Documentation: devicetree: arm: cpus/cpu nodes
 bindings updates
In-Reply-To: <20130913165708.GC5408@e102568-lin.cambridge.arm.com>
References: <1376559743-31848-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1376559743-31848-2-git-send-email-lorenzo.pieralisi@arm.com>
 <520CE665.8060907@gmail.com>
 <20130815152238.GF17839@e102568-lin.cambridge.arm.com>
 <20130913165708.GC5408@e102568-lin.cambridge.arm.com>
Message-ID: <52337AEC.9080302@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2013 11:57 AM, Lorenzo Pieralisi wrote:
> Hi Rob, all,
> 
> On Thu, Aug 15, 2013 at 04:22:38PM +0100, Lorenzo Pieralisi wrote:
>> [adding Andrew, Gregory and Thomas to check the Marvell compatible names]
>>
>> On Thu, Aug 15, 2013 at 03:32:05PM +0100, Rob Herring wrote:
>>> On 08/15/2013 04:42 AM, Lorenzo Pieralisi wrote:
>>>> In order to extend the current cpu nodes bindings to newer CPUs
>>>> inclusive of AArch64 and to update support for older ARM CPUs this
>>>> patch updates device tree documentation for the cpu nodes bindings.
>>>>
>>>> Main changes:
>>>>     - adds 64-bit bindings
>>>>     - define usage of #address-cells
>>>>     - defines behaviour on pre and post v7 uniprocessor systems
>>>>     - adds ARM 11MPcore specific reg property definition
>>>>
>>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/arm/cpus.txt | 424 ++++++++++++++++++++++---
>>>>  1 file changed, 377 insertions(+), 47 deletions(-)
>>>>
>>>
>>> The binding looks mostly fine to me.
> 
> These bindings have still not received an ACK, and need review by
> Marvell guys in copy for the new compatible strings below.

If you can't get comment, then leave them out if they are not used
already. If they are used, then tough shit when they want to change.

> 
> Most importantly, we need to make a decision on the pre v7 uniprocessor
> systems, where MPIDR/CPUID are non-existent and the reg property is a
> pure SW enumeration. Current bindings (ie this patch) define
> 
> #address-cells = <0>;
> 
> for those processors (and there are a number of dts in the kernel with that
> set-up); Grant and Benjamin had a strong feeling against this choice, I
> have to make a decision on how to proceed, please let me know.

I agree that we should define #address-cells to 1 and reg will be simply
0,1,2,etc. in this case.

This change and fixing the example as I pointed out are what I was
waiting to see.

Rob

> 
> Comments welcome.
> 
> Lorenzo
> 
>>>
>>> [snip]
>>>
>>>> +			    "faraday,fa526"
>>>> +			    "intel,sa110"
>>>> +			    "intel,sa1100"
>>>> +			    "marvell,feroceon"
>>>> +			    "marvell,mohawk"
>>>> +			    "marvell,pj4"
>>>> +			    "marvell,sheeva-v7"
>>>> +			    "marvell,xsc3"
>>>> +			    "marvell,xscale"
>>>
>>> Better make sure the Marvell folks are happy with these. We don't need
>>> another rename here. I'm too annoyed with all the renames to pay attention.
>>
>> Ok, I will verify that, I copied maintainers in.
>>
>> On a side note I have just noticed that last cycle some dts were merged in the
>> kernel with cpu nodes that are not compliant (not picking on anyone,
>> eg am4372.dtsi).
>> Please prevent this from happening from now onwards, really please.
>>
>>>> +
>>>> +Example 4 (ARM Cortex-A57 64-bit system running OS in AArch64):
>>>> +
>>>
>>> Going back to my comments that the dtb can't be dependent on the OS,
>>> these 2 examples don't make sense.
>>
>> Gah, my bad sorry, I missed the examples while removing dependency on the OS
>> from the bindings.
>>
>>>> +
>>>> +Example 5 (ARM Cortex-A57 64-bit system running OS in AArch32):
>>>
>>> This example should be removed.
>>
>> Yes, consider it done, see above.
>>
>> Thanks,
>> Lorenzo
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
