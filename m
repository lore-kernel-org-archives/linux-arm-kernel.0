From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 21 Jul 2011 11:03:04 +0530
Subject: [PATCH] ARM: do not mark CPU 0 as hotpluggable
In-Reply-To: <4E2796DA.80001@gmail.com>
References: <1311204745-6276-1-git-send-email-mturquette@ti.com>
	<4E2796DA.80001@gmail.com>
Message-ID: <4E27BA10.3060203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/21/2011 8:32 AM, Rob Herring wrote:
> On 07/20/2011 06:32 PM, Mike Turquette wrote:
>> A quick poll of the ARM platforms that implement CPU Hotplug support
>> shows that every platform treats CPU 0 as a special case that cannot be
>> hotplugged.  In fact every platform has identical code for
>> platform_cpu_die which returns -EPERM in the case of CPU 0.
>>
>> The user-facing sysfs interfaces should reflect this by not populating
>> an 'online' entry for CPU 0 at all.  This better reflects reality by
>> making it clear to users that CPU 0 cannot be hotplugged.
>>
>> This patch prevents CPU 0 from being marked as hotpluggable on all ARM
>> platforms during CPU registration.  This in turn prevents the creation
>> of an 'online' sysfs interface for that CPU.
>>
> Unless there is a kernel limitation why CPU0 can't be hot unplugged,
> then this should remain a platform decision. This may be another case of
> everybody just copying other platforms' code, not a platform limitation.
>
Just talking on behalf of OMAP, we can't offline CPU0 and limitation
would remain in future OMAPs too.

Regards
Santosh
