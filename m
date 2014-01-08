From: ahs3@redhat.com (Al Stone)
Date: Wed, 08 Jan 2014 16:55:58 -0700
Subject: [PATCH v5 1/5] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE_ONLY
 to enforce this ACPI mode
In-Reply-To: <201401081346.25767.arnd@arndb.de>
References: <1389142011-27356-1-git-send-email-al.stone@linaro.org>
 <1389142011-27356-2-git-send-email-al.stone@linaro.org>
 <201401081346.25767.arnd@arndb.de>
Message-ID: <52CDE58E.5000001@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2014 05:46 AM, Arnd Bergmann wrote:
> On Wednesday 08 January 2014, al.stone at linaro.org wrote:
>> Even though support for X86 in hardware reduced mode is possible, it
>> is NOT enabled.  Extensive effort has gone into the Linux kernel so that
>> there is a single kernel image than can run on all x86 hardware; the kernel
>> changes run-time behavior to adapt to the hardware being used.  This is not
>> currently possible with the existing ACPICA infrastructure but only presents
>> a problem on achitectures supporting both hardware-reduced and legacy modes
>> of ACPI -- i.e., on x86 only.
>
> Not sure about the logic here: While it's certainly possible to build a kernel
> that runs on all x86 machines, it's also possible to build one that only
> runs on some of them when some basic options are turned off. I don't see
> any difference between that and what we have on ARM64 or the multiplatform
> subset of ARM32.
>
> I don't think you need any strict architecture dependency here. If you want
> to make it harder for users to accidentally turn it on, I'd suggest using
>
> config ACPI_REDUCED_HARDWARE_ONLY
>         bool "Hardware-reduced ACPI support only"
>         depends on !X86 || EXPERT
>
> 	Arnd

Hrm.  Seems a fair point.  I'll respin the patch set to incorporate
this, though now that I think of it I will add !IA64 since it is
unlikely they'll do a reduced hardware platform any time soon and
would have the same problem as x86.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
