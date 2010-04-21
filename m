From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 20 Apr 2010 23:43:23 -0700
Subject: udelay() broken for SMP cores?
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C4FEED81@dbde02.ent.ti.com>
References: <4BCE60C4.8020505@codeaurora.org>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C4FEED81@dbde02.ent.ti.com>
Message-ID: <4BCE9E8B.2070103@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> I looked at arch/arm/lib/delay.S and it looks like __udelay and
>> __const_udelay won't work correctly for SMP cores. The code just uses
>> the loops_per_jiffy variable instead of the per-CPU loops per jiffy data.
>>
>> Is anyone already working on a fix for that? If not, I can fix it up in
>> a way that's hopefully palatable to the community.
> 

> If you have case where individual CPUs are running at different speed and different
> Tick rate then only this can make difference.

Yes. I was talking about the case where the CPUs could be running at 
different speeds.

Thanks,
Saravana
