From: alex.shi@linaro.org (Alex Shi)
Date: Thu, 1 Mar 2018 19:53:55 +0800
Subject: [PATCH 01/29] arm64: mm: Use non-global mappings for kernel space
In-Reply-To: <20180228120828.GB8453@kroah.com>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <1519790211-16582-2-git-send-email-alex.shi@linaro.org>
 <20180228120828.GB8453@kroah.com>
Message-ID: <92d7d0b8-7483-74d7-efe5-29249093d1ad@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/28/2018 08:08 PM, Greg KH wrote:
> On Wed, Feb 28, 2018 at 11:56:23AM +0800, Alex Shi wrote:
>> From: Will Deacon <will.deacon@arm.com>
>>
>> commit e046eb0c9bf2 upstream.
>>
>> In preparation for unmapping the kernel whilst running in userspace,
>> make the kernel mappings non-global so we can avoid expensive TLB
>> invalidation on kernel exit to userspace.
>>
>> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>> Tested-by: Laura Abbott <labbott@redhat.com>
>> Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Alex Shi <alex.shi@linaro.org>
>>
>> Conflicts:
>> 	skip PTE_RDONLY of PAGE_NONE in arch/arm64/include/asm/pgtable-prot.h
> 
> These "Conflicts:" lines need to be removed, or put below the --- line
> please.
> 

Thanks response! Greg,

There are still a boot hang on one of renesas board on
CONFIG_RANDOMIZE_BASE. I am trying to get help from Renesas guys help on
this. I will back after fix it.

https://kernelci.org/boot/id/5a96f3dd59b5146590b3a4d5/

Thanks
Alex
