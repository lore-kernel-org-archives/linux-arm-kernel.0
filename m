From: al.stone@linaro.org (Al Stone)
Date: Fri, 10 Jan 2014 10:12:32 -0700
Subject: [PATCH v5 1/5] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE_ONLY
 to enforce this ACPI mode
In-Reply-To: <20140110103757.GC925@arm.com>
References: <1389142011-27356-1-git-send-email-al.stone@linaro.org>
 <1389142011-27356-2-git-send-email-al.stone@linaro.org>
 <201401081346.25767.arnd@arndb.de>
 <CAHkRjk50ctWV4Z13wRYh8n6urcTdkq4a8tgKi8k6hgNHA3cVVA@mail.gmail.com>
 <52CF1297.9030306@redhat.com> <20140110103757.GC925@arm.com>
Message-ID: <52D02A00.3000209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2014 03:37 AM, Catalin Marinas wrote:
> On Thu, Jan 09, 2014 at 09:20:23PM +0000, Al Stone wrote:
>> On 01/09/2014 10:38 AM, Catalin Marinas wrote:
>>> On 8 January 2014 12:46, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Wednesday 08 January 2014, al.stone at linaro.org wrote:
>>>>> Even though support for X86 in hardware reduced mode is possible, it
>>>>> is NOT enabled.  Extensive effort has gone into the Linux kernel so that
>>>>> there is a single kernel image than can run on all x86 hardware; the kernel
>>>>> changes run-time behavior to adapt to the hardware being used.  This is not
>>>>> currently possible with the existing ACPICA infrastructure but only presents
>>>>> a problem on achitectures supporting both hardware-reduced and legacy modes
>>>>> of ACPI -- i.e., on x86 only.
>>>>
>>>> Not sure about the logic here: While it's certainly possible to build a kernel
>>>> that runs on all x86 machines, it's also possible to build one that only
>>>> runs on some of them when some basic options are turned off. I don't see
>>>> any difference between that and what we have on ARM64 or the multiplatform
>>>> subset of ARM32.
>>>
>>> Would we ever need !CONFIG_ACPI_REDUCED_HARDWARE_ONLY on ARM or ARM64?
>>> If not, we could even make this always on for these archs.
>>>
>>
>> Not that I know of -- and I would hope not.  This mode is so much
>> more straightforward that it makes no sense to me to do anything
>> but reduced HW if you have the choice.
>
> Thanks for clarifying.
>
>> I assume you were thinking of something like this in the arch Kconfig
>> file:
>>
>> config ARM64
>> 	....
>> 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>> 	...
>>
>> But, do let me know if you had something else in mind.  I think it does
>> make sense to add so I'll put this in the next version.
>
> The change makes sense but I think it should come with the patches for
> ACPI support on arm64 rather than your hw-reduced patches.
>

Ah.  Indeed.  That makes more sense; I'll pass it on to my colleagues.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone at linaro.org
-----------------------------------
