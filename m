From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 10 Jan 2013 13:45:03 +0000
Subject: [PATCH] ARM: nommu: re-enable use of vexpress without
 ARCH_MULTIPLATFORM
In-Reply-To: <50EEC039.3010905@codeaurora.org>
References: <1357755328-17075-1-git-send-email-jonathan.austin@arm.com>
 <20130109204804.GS3931@n2100.arm.linux.org.uk> <50EE3ADA.2070100@gmail.com>
 <201301101016.44708.arnd@arndb.de> <50EEC039.3010905@codeaurora.org>
Message-ID: <50EEC5DF.1010607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/13 13:20, Christopher Covington wrote:
> On 01/10/2013 05:16 AM, Arnd Bergmann wrote:
> 
> [...]
> 
>> I'd certainly be happy with
>>
>> * removing the intentional build error for ARCH_MULTIPLATFORM, but leaving
>>   it in for !ARCH_MULTIPLATFORM
>> * having mach-virt enabled by default on ARCH_MULTIPLATFORM, and only
>>   visible for EXPERT.
>> * making mach-virt compatible with all CPUs starting with ARM7.
>>
>> That would make allnoconfig, allyesconfig and allmodconfig work (besides
>> all the other bugs) on qemu at least, avoid build errors with randconfig
>> and make it hard enough to build a kernel that doesn't run on anything.
> 
> If this is going to be the approach, I would like to once again suggest that
> paths, configuration options, and compatibility strings along the lines of
> "mach-genericarmv7", "Generic ARMv7 Machine", and "linux,genericarmv7" be
> considered in place of "mach-virt", "Dummy Virtual Machine" and
> "linux,dummy-virt", respectively.
> 
> Virtualization may have been the initial motivation for creating mach-virt,
> but the code is clearly also immediately applicable to other environments such
> as simulation/emulation, and sticking to a name like "Dummy Virtual Machine"
> makes it sound like such usage is erroneous.

mach-virt requires GIC, Architected Timers and PSCI. I'm not prepared to
impose these requirements on all future v7 platforms yet.

When we reach a point where we have a completely DT driven setup,
without any explicit hook, I'll be happy to add new compatibility strings.

	M.
-- 
Jazz is not dead. It just smells funny...
