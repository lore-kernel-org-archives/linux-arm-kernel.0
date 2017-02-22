From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 22 Feb 2017 15:41:02 +0800
Subject: [PATCH 2/2] arch_timer: acpi: add hisi timer erratum data
In-Reply-To: <874lzn602f.fsf@on-the-bus.cambridge.arm.com>
References: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
 <1485254391-51551-3-git-send-email-guohanjun@huawei.com>
 <20170124105717.GB6277@leverpostej>
 <a2ac2a70-09fb-5cec-c090-b8ebde90e24f@arm.com> <589D6776.2010400@huawei.com>
 <6c3a2952-731b-dfae-ba22-f9d7df25d691@arm.com> <58AC2AEF.1030803@huawei.com>
 <874lzn602f.fsf@on-the-bus.cambridge.arm.com>
Message-ID: <58AD408E.5080409@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/2/21 23:22, Marc Zyngier wrote:
> On Tue, Feb 21 2017 at 11:56:31 am GMT, Hanjun Guo <guohanjun@huawei.com> wrote:
>> Hi Marc,
> [...]
>
[...]
>>
>> And I got compile errors for this patch [1], seems "#include <linux/acpi.h>" in
>> arch/arm64/include/asm/arch_timer.h triggers the problem of head
>> file inclusions (too early to include <linux/sched.h>?), I'm looking into it,
>> if you can help to take a look too, that will be great :)
> This is really much more complicated (and uglier) than what I had in
> mind, and I don't want to add more cruft to the erratum description
> structure. So instead of trying to explain what I wanted to see, here's
> the patches I whipped together.
>
> Please let me know if they work for you (as I have no way of testing
> them).
>
> Thanks,
>
> 	M.
>
> >From 50eb735436f9f6482285939b39b52d858d848537 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <marc.zyngier@arm.com>
> Date: Tue, 21 Feb 2017 14:37:30 +0000
> Subject: [PATCH 1/2] arm64: arch_timer: Allow erratum matching with ACPI OEM
>  information
>
> Just as we're able to identify a broken platform using some DT
> information, let's enable a way to spot the offenders with ACPI.
>
> The difference is that we can only match on some OEM info instead
> of implementation-specific properties. So in order to avoid the
> insane multiplication of errata structures, we allow an array
> of OEM descriptions to be attached to an erratum structure.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/arch_timer.h  |  1 +
>  drivers/clocksource/arm_arch_timer.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)

Marc, thank you for the help, I tested your patches on D03, I got:

[    0.000000] arm_arch_timer: Enabling global workaround for HiSilicon erratum 161010101
[    0.000000] arm_arch_timer: CPU0: Trapping CNTVCT access

in the boot log, which means the framework and ACPI patches work fine.

Thanks
Hanjun
