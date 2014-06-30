From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Jun 2014 09:23:45 +0200
Subject: [RFC 1/4] ARM: tegra: Move SoC drivers to drivers/soc/tegra
In-Reply-To: <53AEF81D.3080408@ti.com>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
 <20140627232757.GB26184@ulmo> <53AEF81D.3080408@ti.com>
Message-ID: <5279186.O063V9ZcHh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 June 2014 13:15:09 Santosh Shilimkar wrote:
> >> For SMP boot, ARMv8 expecting to have either PSCI based implementation or
> >> device tree based boot scheme. you can move towards that model if possible.
> > 
> > But we also have the code for SMP on 32-bit ARM. Should that remain in
> > arch/arm/mach-tegra or can it move to drivers/soc/tegra?
> > 
> You answered yourself. I don't see any point moving such a code to drivers
> which is really SMP bring up code for ARM 32 bit. For ARM 64 bit, as
> outline by maintainers (Catalin, Arnd), you should use PSCI or DT based
> boot scheme.

I was hoping that one day we could unify the SMP bootup code with the
cpuidle infrastructure, as a lot of the underlying functions are shared
on the majority of SoCs. I have no plans to work on that myself though,
and it would have to be agreed on by the cpuidle maintainers.

For ARM64, the hope was indeed to use PSCI for all SoCs. I just have no
idea how that would be enforced for mobile SoCs that get shipped to
system integrators with an bootloader and kernel tree that doesn't even
get reviewed anywhere first.

	Arnd
