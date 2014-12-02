From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Wed, 3 Dec 2014 02:35:49 +0900
Subject: [PATCH] arm64: Implement support for read-mostly sections
In-Reply-To: <20141202114247.GD26306@e104818-lin.cambridge.arm.com>
References: <7F4979C9-A608-4641-B2DD-0A09FBCCC4A0@gmail.com>
 <20141202114247.GD26306@e104818-lin.cambridge.arm.com>
Message-ID: <143FF770-3BD4-4E60-8406-08148012A475@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dec 2, 2014, at 8:42 PM, Catalin Marinas wrote:
> On Mon, Dec 01, 2014 at 10:01:06PM +0000, Jungseok Lee wrote:
>> As putting data which is read mostly together, we can avoid
>> unnecessary cache line bouncing.
>> 
>> Other architectures, such as ARM and x86, adopted the same idea.
>> 
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
> 
> It looks fine to me, with a nitpick below:
> 
>> ---
>> arch/arm64/include/asm/cache.h | 2 ++
>> 1 file changed, 2 insertions(+)
>> 
>> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
>> index 88cc05b..c1a2a9f 100644
>> --- a/arch/arm64/include/asm/cache.h
>> +++ b/arch/arm64/include/asm/cache.h
>> @@ -30,6 +30,8 @@
>>  */
>> #define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
>> 
>> +#define __read_mostly __attribute__((__section__(".data..read_mostly")))
>> +
>> #ifndef __ASSEMBLY__
> 
> I think we can move this #define below #ifndef as it doesn't make sense
> in .S files anyway.

Okay, I will move it below #ifndef.

> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!
Jungseok Lee
