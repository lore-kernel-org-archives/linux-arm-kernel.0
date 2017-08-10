From: james.morse@arm.com (James Morse)
Date: Thu, 10 Aug 2017 17:57:48 +0100
Subject: [PATCH v2 06/16] arm64: entry.S: convert elX_sync
In-Reply-To: <20170809172527.yrkpthrrtqoxi4d7@armageddon.cambridge.arm.com>
References: <20170728141019.9084-1-james.morse@arm.com>
 <20170728141019.9084-7-james.morse@arm.com>
 <20170809172527.yrkpthrrtqoxi4d7@armageddon.cambridge.arm.com>
Message-ID: <598C908C.9030506@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 09/08/17 18:25, Catalin Marinas wrote:
> On Fri, Jul 28, 2017 at 03:10:09PM +0100, James Morse wrote:
>> @@ -520,9 +514,16 @@ el1_preempt:
>>  el0_sync:
>>  	kernel_entry 0
>>  	mrs	x25, esr_el1			// read the syndrome register
>> +	mrs	x26, far_el1
> 
> Just checking, since we are going to access far_el1 even when we get a
> syscall, have you noticed any overhead?

Good point, I haven't checked because I've been doing all this with the software
model.

I will set this running on Seattle overnight, results in v3's cover letter.


Thanks!

James
