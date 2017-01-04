From: labbott@redhat.com (Laura Abbott)
Date: Wed, 4 Jan 2017 08:50:15 -0800
Subject: [PATCH 1/2] arm: Cleanup sanity_check_meminfo
In-Reply-To: <alpine.LFD.2.20.1701031958100.21662@knanqh.ubzr>
References: <1483477010-18986-1-git-send-email-labbott@redhat.com>
 <1483477010-18986-2-git-send-email-labbott@redhat.com>
 <alpine.LFD.2.20.1701031958100.21662@knanqh.ubzr>
Message-ID: <d4a0af0f-902a-967c-721b-d97905010e45@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2017 05:12 PM, Nicolas Pitre wrote:
> On Tue, 3 Jan 2017, Laura Abbott wrote:
> 
>>
>> The logic for sanity_check_meminfo has become difficult to
>> follow. Clean up the code so it's more obvious what the code
>> is actually trying to do.
> 
> Absolutely. This function has a long history of subtle bugs ... and 
> broken fixes.
> 
>> +		if (reg->base < vmalloc_limit) {
>> +			if (block_end > arm_lowmem_limit)
>> +				arm_lowmem_limit = min(
>> +						(phys_addr_t)vmalloc_limit,
>> +						block_end);
> 
> Just to illustrate how subtle this can be, the above would reintroduce a 
> bug that was fixed in commit b9a019899f.
> 
> 
> Nicolas
> 

Yup, I saw that commit and thought "I need to keep the fix". And yet I
still managed to get it wrong. I'll fix in a v2.

Thanks,
Laura
