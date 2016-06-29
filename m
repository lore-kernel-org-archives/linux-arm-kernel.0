From: yu.c.chen@intel.com (Chen Yu)
Date: Wed, 29 Jun 2016 18:02:39 +0800
Subject: [PATCH v3 5/7] PM / Hibernate: Allow arch code to influence CPU
 hotplug during hibernate
In-Reply-To: <7811260.OWJXivZiAP@vostro.rjw.lan>
References: <1467125510-18758-1-git-send-email-james.morse@arm.com>
 <1467125510-18758-6-git-send-email-james.morse@arm.com>
 <7811260.OWJXivZiAP@vostro.rjw.lan>
Message-ID: <57739CBF.2090706@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016?06?29? 08:10, Rafael J. Wysocki wrote:
> On Tuesday, June 28, 2016 03:51:48 PM James Morse wrote:
>> Architecture code may need to do extra work when secondary CPUs are
>> disabled during hibernate and resume. This may include pushing sleeping
>> CPUs into a deeper power-saving state, or influencing which CPU resume
>> occurs on.
>>
>> Define a macro arch_hibernation_disable_cpus(), which defaults to calling
>> disable_nonboot_cpus() if undefined. Architectures that need to do extra
>> work around these calls can use this to influence disable_nonboot_cpus()
>> behaviour. The macro should be defined in asm/suspend.h, and
>> ARCH_HIBERNATION_CPUHP should be added to Kconfig.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Pavel Machek <pavel@ucw.cz>
> As you noted, this could be used to address the x86 issue that Yu is working on,
> so I'd like it to go in as the first patch in the series and through the PM tree.
>
This patch looks friendly for that fix :), thanks.
> For the x86 case we'll also need the complementary "enable", so why don't
> you add it here and then use it instead of the enable_nonboot_cpus()?
>
Agreed.

Yu
