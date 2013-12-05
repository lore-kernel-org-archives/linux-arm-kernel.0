From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Dec 2013 23:25:02 +0100
Subject: [RFC part1 PATCH 0/7] Make ACPI core running on ARM64
In-Reply-To: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <201312052325.02603.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 December 2013, Hanjun Guo wrote:
> This is the first part of making ACPI core running on ARM.
> 
> PCI is optional on ARM64 but ACPI is dependent on PCI now, so
> in the first patch we try to make ACPI can be running without
> PCI.
> 
> _PDC is requred for ACPI processor_core.c, but its related code
> is a little bit x86/ia64 dependent, so I rework _PDC related staff
> to make it more arch independent, and then introduce the skeleton
> of _PDC related for ARM64, it should be fully implemented after
> ACPI spec is ready for processor idle control.
> 
> After that, arm-core.c is introduced so we can get ACPI table from
> UEFI, then we can parsed for SMP initialisation, GIC initialisation
> and for ACPI drivers.
> 
> This patch set is based on:
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> 
> origin/linux-next branch and plus Al Stone's v2 reduced hardware profile
> patch.

As a meta-comment, I looked over all your patches and none of this looks
scary. It's definitely good that you're doing this work to put the patches
out here for discussion and to get the get the details of this sorted out.
It already looks much better than the earlier snapshots I had looked at
in git trees in the past.

However, as I mentioned before I am much more worried about the parts that
are not done (or not posted) yet and that will be required to actually
have working support for a real server system. Until we know more about
where this is heading, I think we should not merge any of the ARM specific
parts of your patches. Any patches that are reasonable cleanups and bug
fixes for the ACPI subsystem should of course get merged once they are
reviewed.

	Arnd
