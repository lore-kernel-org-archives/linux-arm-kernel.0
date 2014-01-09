From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 9 Jan 2014 17:38:48 +0000
Subject: [PATCH v5 1/5] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE_ONLY
 to enforce this ACPI mode
In-Reply-To: <201401081346.25767.arnd@arndb.de>
References: <1389142011-27356-1-git-send-email-al.stone@linaro.org>
 <1389142011-27356-2-git-send-email-al.stone@linaro.org>
 <201401081346.25767.arnd@arndb.de>
Message-ID: <CAHkRjk50ctWV4Z13wRYh8n6urcTdkq4a8tgKi8k6hgNHA3cVVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 January 2014 12:46, Arnd Bergmann <arnd@arndb.de> wrote:
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

Would we ever need !CONFIG_ACPI_REDUCED_HARDWARE_ONLY on ARM or ARM64?
If not, we could even make this always on for these archs.

-- 
Catalin
