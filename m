From: vkuzmichev@mvista.com (Vitaly Kuzmichev)
Date: Wed, 06 Jul 2011 19:06:19 +0400
Subject: [PATCH V2 0/6] arm_smp_twd: mpcore_wdt: Fix MPCORE watchdog setup
In-Reply-To: <4E145787.9080600@arm.com>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
	<1309892440-3260-1-git-send-email-vkuzmichev@mvista.com>
	<4E14337F.1050101@arm.com> <4E1454BD.7050607@mvista.com>
	<4E145787.9080600@arm.com>
Message-ID: <4E1479EB.2060908@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 07/06/2011 04:39 PM, Marc Zyngier wrote:
> On 06/07/11 13:27, Vitaly Kuzmichev wrote:
>> Hi Marc,
>>
>> On 07/06/2011 02:05 PM, Marc Zyngier wrote:
>> [...]
>>>> The series of patches is based on arm-platforms.git/local_timers_as_devices
>>>> branch since it looks like that it is going to be merged into the mainline.
>>>
>>> Be careful here. This branch is a work in progress, likely to change
>>> very quickly, contains code that has not been posted to the ML yet, and
>>> will probably eat your pet for breakfast. As far as mainline merging is
>>> concerned, there is still a long way to go (see the GIC consolidation
>>> patches, on which the local_timers_as_devices branch relies).
>>
>> I understand.
>> When do you plan to finish this job?
>> Would not it be better to prepare two sets of patches: first one for
>> linux-2.6/master with exported function, second for arm-platforms.git
>> with removing exported function and replacing use of it by
>> clk_get_rate(smp_twd) call?
>> Is there a chance in this case, that my patches will be merged much
>> earlier than yours?
> 
> Your guess is as good as mine. It all depends on people's bandwidth to
> review long series of patches (the particular branch you used is a merge
> of 3 different series), so I'd expect a smaller, less intrusive series
> to make it quicker than my monster patch sets... ;-)

Ok, but then we are coming back to the V1 series containing the
following patches:
  ARM: smp_twd: mpcore_wdt: Fix watchdog counter loading
  ARM: smp_twd: Fix typo in twd_timer_rate printout
  ARM: mpcore_wdt: Fix WDIOC_SETOPTIONS handling
  ARM: mpcore_wdt: Fix timer mode setup

The patches V2 5/6 (Add cpufreq notifier to reload counter) and V2 6/6
(Move declarations in a separate header) are useless without smp_twd
clock and can be threw out.

I will rebase and update V1 series and repost them soon.

Thanks,
Vitaly.
