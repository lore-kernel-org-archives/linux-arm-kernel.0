From: vkuzmichev@mvista.com (Vitaly Kuzmichev)
Date: Wed, 06 Jul 2011 16:27:41 +0400
Subject: [PATCH V2 0/6] arm_smp_twd: mpcore_wdt: Fix MPCORE watchdog setup
In-Reply-To: <4E14337F.1050101@arm.com>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
	<1309892440-3260-1-git-send-email-vkuzmichev@mvista.com>
	<4E14337F.1050101@arm.com>
Message-ID: <4E1454BD.7050607@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 07/06/2011 02:05 PM, Marc Zyngier wrote:
[...]
>> The series of patches is based on arm-platforms.git/local_timers_as_devices
>> branch since it looks like that it is going to be merged into the mainline.
> 
> Be careful here. This branch is a work in progress, likely to change
> very quickly, contains code that has not been posted to the ML yet, and
> will probably eat your pet for breakfast. As far as mainline merging is
> concerned, there is still a long way to go (see the GIC consolidation
> patches, on which the local_timers_as_devices branch relies).

I understand.
When do you plan to finish this job?
Would not it be better to prepare two sets of patches: first one for
linux-2.6/master with exported function, second for arm-platforms.git
with removing exported function and replacing use of it by
clk_get_rate(smp_twd) call?
Is there a chance in this case, that my patches will be merged much
earlier than yours?
If not, I will just rework patch 2/6 to remove exported and use only
clock interface.


Thanks,
Vitaly.
