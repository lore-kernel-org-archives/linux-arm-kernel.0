From: alex.shi@linaro.org (Alex Shi)
Date: Thu, 15 May 2014 16:44:29 +0800
Subject: RCU stall on panda
In-Reply-To: <20140513153220.GC16837@atomide.com>
References: <53675C5F.10509@linaro.org>
 <20140505180617.GM8754@linux.vnet.ibm.com>
 <20140512212102.GF5668@atomide.com> <5371BD69.8010600@linaro.org>
 <20140513153220.GC16837@atomide.com>
Message-ID: <53747E6D.60500@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2014 11:32 PM, Tony Lindgren wrote:
> * Alex Shi <alex.shi@linaro.org> [140512 23:37]:
>> On 05/13/2014 05:21 AM, Tony Lindgren wrote:
>>> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [140505 11:11]:
>>>> On Mon, May 05, 2014 at 05:39:43PM +0800, Alex Shi wrote:
>>>>> I keep seeing the RCU stall problem on panda board from 3.10 kernel to latest upstream kernel
>>>>> and google find some one report it before: https://lkml.org/lkml/2012/9/20/519
>>>>>
>>>>> Is it the hardware issue or a real software problem?
>>>>
>>>> I cannot distinguish between hardware and software from the trace below,
>>>> but given that you are also seeing a soft lockup, either way you do
>>>> appear to have a real problem as opposed to an RCU CPU stall warning
>>>> false positive.
>>>
>>> Looks like you have CPU_IDLE enabled on panda. Hangs with current linux
>>> next with CPU_IDLE are currently being discussed on the linux-omap list
>>> in thread "omap4-panda-es boot issues with v3.15-rc4"
>>>
>>> I've seen occasional system hangs, and I've also noticed that doing
>>> ctrl-a-f h or ctrl-a-f l for sysrq backtrace can unlock the system
>>> producing similar errors to the below.
>>>
>>
>> Thanks a lot for the info.
>> In fact, the oops keeps in upstream kernel from 3.10 to latest.
> 
> Care to test if the revert of commit cb7094 Santosh posted as
> "[PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled"
> solves the problem for you?
> 

After enable this patch, system maybe hang in idle. :(

> Regards,
> 
> Tony
> 


-- 
Thanks
    Alex
