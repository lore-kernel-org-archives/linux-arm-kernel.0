From: zhangshaokun@hisilicon.com (Zhangshaokun)
Date: Tue, 9 Oct 2018 21:53:44 +0800
Subject: [PATCH] arm64: mm: Drop the unused cpu parameter
In-Reply-To: <20181009115704.GC6248@arm.com>
References: <1538815744-27408-1-git-send-email-zhangshaokun@hisilicon.com>
 <20181009115704.GC6248@arm.com>
Message-ID: <95d1728d-2e48-0b05-e25f-fc9b03e9c31c@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 2018/10/9 19:57, Will Deacon wrote:
> On Sat, Oct 06, 2018 at 04:49:04PM +0800, Shaokun Zhang wrote:
>> Cpu parameter is never used in flush_context, remove it.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> ---
>>  arch/arm64/mm/context.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Curious, but does this actually result in better code generation, or does
> GCC already figure out that the parameter is unused?
> 

No hint from GCC compiler, the unused parameter is found when debug one
context switch issue and analyze the code. It is redundant and harmless
to remove it, a trivial patch.

Thanks,
Shaokun

> Will
> 
> .
> 
