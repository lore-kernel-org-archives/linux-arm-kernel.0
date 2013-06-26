From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 26 Jun 2013 12:24:09 -0600
Subject: [PATCH 7/8] ARM: tegra: move cpuidle drivers to drivers/cpuidle/
In-Reply-To: <1372241747-21083-8-git-send-email-b.zolnierkie@samsung.com>
References: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
 <1372241747-21083-8-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <51CB31C9.7050505@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2013 04:15 AM, Bartlomiej Zolnierkiewicz wrote:
> Compile tested only.

That's not a good patch description; it's more something that should be
below the --- line.

This would be a lot easier to review if "-M" had been passed to "git
format-patch" so that the move was actually represented as a move in the
patch.

This patch would need to move at least part of
arch/arm/mach-tegra/cpuidle.h to some common location, since core code
that's left in arch/arm/mach-tegra ends up calling functions in the
moved files to initialize the cpuidle driver.

You should probably move arch/arm/mach-tegra/cpuidle.c too.

Does it make sense to introduce a new Kconfig option into
drivers/cpuidle/Kconfig, so that cpuidle-tegra*.c isn't compiled if
ARCH_TEGRA is enabled, but rather if something more like CPU_IDLE_TEGRA
is enabled?
