From: ddaney@caviumnetworks.com (David Daney)
Date: Thu, 12 May 2016 08:27:08 -0700
Subject: [PATCH v6 13/14] arm64, acpi, numa: NUMA support based on SRAT
 and SLIT
In-Reply-To: <20160512094915.GD11226@e104818-lin.cambridge.arm.com>
References: <1461780436-27182-1-git-send-email-ddaney.cavm@gmail.com>
 <1461780436-27182-14-git-send-email-ddaney.cavm@gmail.com>
 <20160511103929.GC3051@e104818-lin.cambridge.arm.com>
 <5733C8F5.6090206@caviumnetworks.com>
 <20160512094915.GD11226@e104818-lin.cambridge.arm.com>
Message-ID: <5734A0CC.8010600@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2016 02:49 AM, Catalin Marinas wrote:
> On Wed, May 11, 2016 at 05:06:13PM -0700, David Daney wrote:
>> On 05/11/2016 03:39 AM, Catalin Marinas wrote:
[...]
>>>
>>> I wonder whether you could replace the get_mpidr_in_madt() function with
>>> something like acpi_get_phys_id(). It looks like get_mpidr_in_madt()
>>> duplicates functionality already available elsewhere.
>>
>> I just tried that, and it doesn't work.
>>
>> The problem is that this code is being run very early in the boot, and
>> kmalloc cannot be used.  acpi_get_phys_id() and its ilk can only be used
>> once we have working kmalloc.  We need to extract the NUMA information early
>> like this precisely because it is needed to initializing the slab system
>>
>> Notice that we are using early_acpi_os_unmap_memory() et al. in
>> get_mpidr_in_madt() explicitly for this reason.
>>
>> In summary: I don't think we need another revision of this patch, it is like
>> this for a good reason.
>
> Slightly confusing, in another reply you said you are going to address
> my comment. So, is it doable?

I don't think so.

My previous reply, to the thread in 0/14, was prematurely made with the 
incorrect assumption that it was a simple change.  Now, after really 
digging in to the code, and attempting to do as you suggested, I have 
changed my mind.

As I indicated above, there are no remaining suggestions or requests for 
changes to this patch set pending action.  Unless people find additional 
problems, I think it is ready for merging.

I know that Will and Rafael were discussing the proper timing for 
merging this in the other thread, so I leave it in their hands at this 
point.

Thanks,
David Daney


>
