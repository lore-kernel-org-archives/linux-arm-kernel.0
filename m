From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Tue, 03 Aug 2010 15:31:09 -0700
Subject: hotplug and init section
In-Reply-To: <20100722205753.GU31293@n2100.arm.linux.org.uk>
References: <989bc3c9f8d8ce1d51c480a0dbdce07e.squirrel@www.codeaurora.org>
	<20100722205753.GU31293@n2100.arm.linux.org.uk>
Message-ID: <4C5898AD.9020300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Thu, Jul 22, 2010 at 12:33:08PM -0700, smuckle at codeaurora.org wrote:
>> Changing things so
>> that the code required for bringing up secondary cores is still present
>> after init looks to be a fairly big change. As such I wanted to see if
>> anyone had thoughts here before I start hacking up head.S, the linker
>> script, etc.
>>     
>
> No need to hack the linker script - all you need to do is to ensure that
> the required parts of code are placed in the cpuinit sections - and there's
> a macro to do that called "__CPUINIT" (which equates to a .section
> directive.)
>
> You'll need to ensure that stuff which shouldn't be in the cpuinit
> section remains as-is, so you'll have to also add __INIT or
> .section .text as appropriate.
>   
So I've been looking into this, and it does look like I need to change 
the linker script. I need the secondary_startup function to be around at 
hotplug time, and it appears that the whole head section gets freed with 
the init section. Does it seem sane to make it so the head section isn't 
freed when hotplug is configured? Or should I move the secondary startup 
function out of the head section?

Thanks,
Jeff

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
