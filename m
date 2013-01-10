From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 10 Jan 2013 08:20:57 -0500
Subject: [PATCH] ARM: nommu: re-enable use of vexpress without
 ARCH_MULTIPLATFORM
In-Reply-To: <201301101016.44708.arnd@arndb.de>
References: <1357755328-17075-1-git-send-email-jonathan.austin@arm.com>
 <20130109204804.GS3931@n2100.arm.linux.org.uk> <50EE3ADA.2070100@gmail.com>
 <201301101016.44708.arnd@arndb.de>
Message-ID: <50EEC039.3010905@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2013 05:16 AM, Arnd Bergmann wrote:

[...]

> I'd certainly be happy with
> 
> * removing the intentional build error for ARCH_MULTIPLATFORM, but leaving
>   it in for !ARCH_MULTIPLATFORM
> * having mach-virt enabled by default on ARCH_MULTIPLATFORM, and only
>   visible for EXPERT.
> * making mach-virt compatible with all CPUs starting with ARM7.
> 
> That would make allnoconfig, allyesconfig and allmodconfig work (besides
> all the other bugs) on qemu at least, avoid build errors with randconfig
> and make it hard enough to build a kernel that doesn't run on anything.

If this is going to be the approach, I would like to once again suggest that
paths, configuration options, and compatibility strings along the lines of
"mach-genericarmv7", "Generic ARMv7 Machine", and "linux,genericarmv7" be
considered in place of "mach-virt", "Dummy Virtual Machine" and
"linux,dummy-virt", respectively.

Virtualization may have been the initial motivation for creating mach-virt,
but the code is clearly also immediately applicable to other environments such
as simulation/emulation, and sticking to a name like "Dummy Virtual Machine"
makes it sound like such usage is erroneous.

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by
the Linux Foundation
