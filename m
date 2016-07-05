From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 05 Jul 2016 14:28:50 +0200
Subject: [PATCH v4 1/3] PM / Hibernate: Allow arch code to influence CPUs
 disabled during hibernate
In-Reply-To: <1467643950-11034-2-git-send-email-james.morse@arm.com>
References: <1467643950-11034-1-git-send-email-james.morse@arm.com>
 <1467643950-11034-2-git-send-email-james.morse@arm.com>
Message-ID: <2602641.slsnqsKrbn@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 04, 2016 03:52:28 PM James Morse wrote:
> Architecture code may need to do extra work when secondary CPUs are
> disabled during hibernate and resume. This may include pushing sleeping
> CPUs into a deeper power-saving state, or influencing which CPU resume
> occurs on.
> 
> Define a macro arch_hibernation_disable_cpus(), which defaults to
> calling disable_nonboot_cpus() if undefined. Architectures that
> need to do extra work around these calls can use this to influence
> the CPU down calls.
> The macros should be defined in asm/suspend.h, and
> ARCH_HIBERNATION_CPU_HOOKS should be added to Kconfig.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>

I'm going to apply this one later today.

If you want me to apply the other two as well, they need to be ACKed by the
ARM64 maintainers.

Thanks,
Rafael
