From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Wed, 28 Sep 2016 16:08:01 +0200
Subject: [PATCH v3 1/3] ipmi: add an Aspeed BT IPMI BMC driver
In-Reply-To: <85dc3a75-46e0-87ec-91d5-31e686103ee0@acm.org>
References: <1474354900-5618-1-git-send-email-clg@kaod.org>
 <1474354900-5618-2-git-send-email-clg@kaod.org>
 <20160923183421.GA14864@rob-hp-laptop>
 <c3f084ab-9f77-86ab-7875-cbfe654ea18e@kaod.org>
 <85dc3a75-46e0-87ec-91d5-31e686103ee0@acm.org>
Message-ID: <51788cf6-5d7d-dd74-1083-bdc5ecbd9756@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2016 03:53 PM, Corey Minyard wrote:
> On 09/26/2016 01:50 AM, C?dric Le Goater wrote:
>>
>>>>   Changes since v1:
>>>>
>>>>   - replace 'bt_host' by 'bt_bmc' to reflect that the driver is
>>>>     the BMC side of the IPMI BT interface
>>>>   - renamed the device to 'ipmi-bt-host'
>>>>   - introduced a temporary buffer to copy_{to,from}_user
>>>>   - used platform_get_irq()
>>>>   - moved the driver under drivers/char/ipmi/ but kept it as a misc
>>>>     device
>>>>   - changed the compatible cell to "aspeed,ast2400-bt-bmc"
>>>>
>>>>   .../bindings/char/ipmi/aspeed,ast2400-bt-bmc.txt   |  23 +
>>> While similar, this is not the kernel directory structure. Just make
>>> this bindings/ipmi/
>>>
>>> With that,
>>>
>>> Acked-by: Rob Herring <robh@kernel.org>
>> OK. So I suppose we should be moving all IPMI documentation under
>> the same directory.
>>
>>
>> Corey,
>>
>> If the move is okay for you, I can send the patch below.
>>
>> Thanks,
>>
>> C.
> 
> Sorry this took so long, I'm at a conference.  That change is fine, it does
> seem to match the structure better.

It's ok. 

Checkpatch really does not like that patch and I don't know what we can
do about it. You've been warned :) 

Thanks, 

C. 


./scripts/checkpatch.pl --strict  0001-dt-bindings-ipmi-move-all-documentation-under-bindin.patch
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#12: 
 .../devicetree/bindings/{char => }/ipmi/aspeed,ast2400-bt-bmc.txt         | 0

ERROR: Does not appear to be a unified-diff format patch

total: 1 errors, 1 warnings, 0 checks, 0 lines checked
