From: cyril@ti.com (Cyril Chemparathy)
Date: Fri, 21 Sep 2012 18:49:26 -0400
Subject: [PATCH v3 17/17] ARM: mm: clean up membank size limit checks
In-Reply-To: <alpine.LFD.2.02.1209211441520.6667@xanadu.home>
References: <1347385155-11643-1-git-send-email-cyril@ti.com>
 <1347385155-11643-18-git-send-email-cyril@ti.com>
 <alpine.LFD.2.02.1209211441520.6667@xanadu.home>
Message-ID: <505CEEF6.1050205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/21/2012 2:42 PM, Nicolas Pitre wrote:
> On Tue, 11 Sep 2012, Cyril Chemparathy wrote:
>
>> This patch cleans up the highmem sanity check code by simplifying the range
>> checks with a pre-calculated size_limit.  This patch should otherwise have no
>> functional impact on behavior.
>>
>> This patch also removes a redundant (bank->start < vmalloc_limit) check, since
>> this is already covered by the !highmem condition.
>>
>> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
>> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
>
> Acked-by: Nicolas Pitre <nico@linaro.org>
>

Thanks, Nico.

Could you please take another peek at patch 05/17 (support 64-bit 
virt_to_phys patching)?  You had reviewed it in an earlier posting, but 
I've had to tweak the code to optimize the compiler generated inline 
expansion code.

Patch 14/17 (accomodate >32-bit addresses for page table base) could use 
some attention as well.  The same goes with 12/17 (define 
ARCH_LOW_ADDRESS_LIMIT for bootmem), if you could.

-- 
Thanks
- Cyril
