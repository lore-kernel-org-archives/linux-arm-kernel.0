From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Tue, 8 Dec 2015 10:35:51 -0600
Subject: [PATCH] ARM:VDSO: use PTR_ERR_OR_ZERO for vma check
In-Reply-To: <5654DC2E.7080908@mentor.com>
References: <20151124065536.GA21679@jci-VirtualBox>
 <5654DC2E.7080908@mentor.com>
Message-ID: <566706E7.5010200@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/2015 03:52 PM, Nathan Lynch wrote:
> On 11/24/2015 12:56 AM, Mutharaju, Prasanna (P.) wrote:
>> From: Prasanna Karthik <mkarthi3@visteon.com>
>>
>> Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
>>
>> Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
>> ---
>>  arch/arm/kernel/vdso.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
>> index 54a5aea..994e971 100644
>> --- a/arch/arm/kernel/vdso.c
>> +++ b/arch/arm/kernel/vdso.c
>> @@ -224,7 +224,7 @@ static int install_vvar(struct mm_struct *mm, unsigned long addr)
>>  				       VM_READ | VM_MAYREAD,
>>  				       &vdso_data_mapping);
>>  
>> -	return IS_ERR(vma) ? PTR_ERR(vma) : 0;
>> +	return PTR_ERR_OR_ZERO(vma);
>>  }
>>  
> 
> Thanks, I think this is fine, but I won't be able to properly process
> this until next week.

I've verified that this results in no change in generated code, and I
have sent it to Russell to queue for 4.5, thanks.
