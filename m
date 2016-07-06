From: james.morse@arm.com (James Morse)
Date: Wed, 06 Jul 2016 10:16:15 +0100
Subject: [PATCH v4 1/3] PM / Hibernate: Allow arch code to influence CPUs
 disabled during hibernate
In-Reply-To: <2602641.slsnqsKrbn@vostro.rjw.lan>
References: <1467643950-11034-1-git-send-email-james.morse@arm.com>
 <1467643950-11034-2-git-send-email-james.morse@arm.com>
 <2602641.slsnqsKrbn@vostro.rjw.lan>
Message-ID: <577CCC5F.2060409@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On 05/07/16 13:28, Rafael J. Wysocki wrote:
> On Monday, July 04, 2016 03:52:28 PM James Morse wrote:
>> Architecture code may need to do extra work when secondary CPUs are
>> disabled during hibernate and resume. This may include pushing sleeping
>> CPUs into a deeper power-saving state, or influencing which CPU resume
>> occurs on.
>>
>> Define a macro arch_hibernation_disable_cpus(), which defaults to
>> calling disable_nonboot_cpus() if undefined. Architectures that
>> need to do extra work around these calls can use this to influence
>> the CPU down calls.
>> The macros should be defined in asm/suspend.h, and
>> ARCH_HIBERNATION_CPU_HOOKS should be added to Kconfig.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Pavel Machek <pavel@ucw.cz>
> 
> I'm going to apply this one later today.
> 
> If you want me to apply the other two as well, they need to be ACKed by the
> ARM64 maintainers.

Thanks. I'd like to get to the bottom of Lorenzo's comments[0] before the arm64
patches go any further though!

Thanks,


James


[0] http://www.spinics.net/lists/arm-kernel/msg516244.html
