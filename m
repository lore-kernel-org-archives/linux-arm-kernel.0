From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 09 Jan 2014 12:52:21 -0800
Subject: [PATCH v4 4/6] devicetree: bindings: Document Krait L1/L2 EDAC
In-Reply-To: <20140108100538.GA2927@e102568-lin.cambridge.arm.com>
References: <1388434457-4194-1-git-send-email-sboyd@codeaurora.org>
 <1388434457-4194-5-git-send-email-sboyd@codeaurora.org>
 <20140107105439.GC5906@e102568-lin.cambridge.arm.com>
 <20140107201239.GD14405@codeaurora.org>
 <20140108100538.GA2927@e102568-lin.cambridge.arm.com>
Message-ID: <52CF0C05.1080308@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/14 02:05, Lorenzo Pieralisi wrote:
> On Tue, Jan 07, 2014 at 08:12:39PM +0000, Stephen Boyd wrote:
>> On 01/07, Lorenzo Pieralisi wrote:
>>
>>> I have a problem with the cache level definition, and in
>>> particular the numbering, ie what the level number represents. If we
>>> mean the cache level seen through the CLIDR and co., it is hard to use
>>> it for shared caches since the level seen by different CPUs can actually
>>> be different, or put it differently the level number might not be unique for
>>> a shared cache. I need to think about a proper way to sort this out.
>>>
>> Ok. I don't even use this property in my driver. All I really
>> need is the phandle from cpus pointing to the L2 and the
>> interrupts property in the L2 node.
>>
>> How do you want to proceed here? If your cache binding goes
>> through I would just need to add the interrupts part. Or you
>> could even add that part in the same patch, you could have my
>> signed-off-by for that.
> Ok, I will try to update the bindings with the interrupt part and copy
> you in, even though the level definition worries me a bit, it is an
> important property for power management and I need to find a proper
> solution before bindings can get accepted (basically the problem is:
> if different CPUs can see a cache at different levels as defined in the
> CLIDR we cannot describe a cache with a single cache level or put it
> differently, level can not represent the value in the CLIDR hence we
> need to describe it differently).

Ok. I've dropped the cache part from this patch. I left the example as
is minus the cache-level attribute.

Understanding how the cache-level value would be used might help. I
wonder if the cache-level can just be a number that describes the
largest value that the cache could be assigned. Then if you have
different CPUs seeing different levels of cache they can traverse from
their CPU node to the cache and count how many phandles they went through.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
