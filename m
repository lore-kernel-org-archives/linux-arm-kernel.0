From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 21 Aug 2015 11:45:18 -0500
Subject: [PATCH v3 15/31] arm64: SMP support
In-Reply-To: <55C8D9DB.5080207@codeaurora.org>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-16-git-send-email-catalin.marinas@arm.com>
 <CAOZdJXVoDJM3y2mnKO+91yf2EHogKfMjumjhhi85REAfhcJM=Q@mail.gmail.com>
 <20150806095621.GB17691@e104818-lin.cambridge.arm.com>
 <55C8843D.8050600@linaro.org> <55C8D9DB.5080207@codeaurora.org>
Message-ID: <55D7559E.8080609@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2015 12:05 PM, Timur Tabi wrote:
>>>
>>> This code was inherited from arch/arm which initially was always dumping
>>> the stack but it later gained the system_state check. Unless it's useful
>>> to anyone for debugging purposes, I'm ok with removing it.
>>
>> Do you have patch for this one? My colleagues said that they met the
>> same problem :)
>
> Dropping the call to dump_stack() would probably be sufficient.

Actually, I think we need to keep it.  I just heard from another 
developer who does actually use it for debugging.

I think the real problem is that emergency_restart() should not be 
causing these outputs.  Shouldn't machine_restart() change the 
system_state to SYSTEM_RESTART before it calls smp_send_stop()?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
