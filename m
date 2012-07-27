From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 27 Jul 2012 08:56:06 -0400
Subject: [PATCH 02/24] xen/arm: hypercalls
In-Reply-To: <1343380764.6812.108.camel@zakaz.uk.xensource.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>	
 <1343316846-25860-2-git-send-email-stefano.stabellini@eu.citrix.com>	
 <50119856.2020206@codeaurora.org>
 <1343380764.6812.108.camel@zakaz.uk.xensource.com>
Message-ID: <50128FE6.5070109@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2012 05:19 AM, Ian Campbell wrote:
> On Thu, 2012-07-26 at 20:19 +0100, Christopher Covington wrote:
>> Hi Stefano,
>>
>> On 07/26/2012 11:33 AM, Stefano Stabellini wrote:
>>> Use r12 to pass the hypercall number to the hypervisor.
>>>
>>> We need a register to pass the hypercall number because we might not
>>> know it at compile time and HVC only takes an immediate argument.
>>
>> You're not going to JIT assemble the appropriate HVC instruction? Darn.
> 
> ;-)
> 
>> How many call numbers are there, though? 8?
> 
> The maximum currently defined hypercall number is 55, although there are
> some small gaps so there's actually more like 45 in total.
> 
>>  It seems like it'd be
>> reasonable to take the approach that seems to be favored for MRC/MCR
>> instructions, using a function containing switch statement that chooses
>> between several inline assembly instructions based off an enum passed to
>> the function. See for example arch_timer_reg_read in
>> arch/arm/kernel/arch_timer.c.
> 
> I don't think it is feasible with this number of hypercalls, even
> accepting that in many cases the number will be a constant so gcc can
> likely optimise almost all of it away.
> 
> Is there something wrong with the r12 based approach?

Only that you're defining a custom interface for something that there is
a potentially more standard interface for. I just wanted to double check
that all the ways of using the potentially more standard interface had
been explored and found to be unreasonable.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
