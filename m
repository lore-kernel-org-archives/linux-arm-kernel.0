From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 15 May 2012 22:51:27 +0200
Subject: [Linaro-mm-sig] [PATCH] ARM: LPAE: fix access flag setup in
 mem_type_table
In-Reply-To: <20120515122215.GK10453@n2100.arm.linux.org.uk>
References: <1337018097-27308-1-git-send-email-vitalya@ti.com>
 <20120515122215.GK10453@n2100.arm.linux.org.uk>
Message-ID: <4FB2C1CF.2030208@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 5/15/2012 2:22 PM, Russell King - ARM Linux wrote:
> On Mon, May 14, 2012 at 01:54:57PM -0400, Vitaly Andrianov wrote:
>> A zero value for prot_sect in the memory types table implies that
>> section mappings should never be created for the memory type in question.
>> This is checked for in alloc_init_section().
>>
>> With LPAE, we set a bit to mask access flag faults for kernel mappings.
>> This breaks the aforementioned (!prot_sect) check in alloc_init_section().
>>
>> This patch fixes this bug by first checking for a non-zero
>> prot_sect before setting the PMD_SECT_AF flag.
>>
>> Signed-off-by: Vitaly Andrianov<vitalya@ti.com>
>>
>> Acked-by: Catalin Marinas<catalin.marinas@arm.com>
>
> Please put this in the patch system.  No blank line is needed between
> s-off-by and acked-by.

This patch fixes the issue introduced by adding CMA to ARM architecture 
which I've pushed for testing to linux-next. I've added it to my 
for-next-cma branch:

http://git.linaro.org/gitweb?p=people/mszyprowski/linux-dma-mapping.git;a=shortlog;h=refs/heads/for-next-cma

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
