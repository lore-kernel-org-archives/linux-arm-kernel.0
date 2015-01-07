From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Jan 2015 11:07:38 +0000
Subject: [PATCH 0/2] arm64: first set of Kconfig patches for Tegra132
 support
In-Reply-To: <20150107081638.14381.42444.stgit@dusk.lan>
References: <20150107081638.14381.42444.stgit@dusk.lan>
Message-ID: <20150107110738.GF7485@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 08:17:29AM +0000, Paul Walmsley wrote:
> Hi Catalin & Will,

Hi Paul,

> These patches start the ARM64 Kconfig and defconfig changes to
> support the Tegra132 (aka Tegra K1 64-bit) SoC and the NVIDIA
> Norrin64 FFD board.
> 
> Tegra132 support is made conditional on CONFIG_BROKEN, since
> there are some patches pending for other maintainers to fix
> compilation when CONFIG_ARCH_TEGRA is set during an ARM64 build.
> Once those patches have been merged, a subsequent patch will be
> sent to remove the CONFIG_BROKEN dependency and to make a few other
> defconfig changes that are dependent on CONFIG_ARCH_TEGRA.
> 
> These patches apply on the arm64 fixes/core branch, commit
> 5d96e0cba263.  They have been boot-tested on QEMU 2.2.0 AArch64,
> and (after other patches have been applied) have been boot-tested
> on the Tegra132 Norrin64 FFD board.

Whilst I'm happy to take the second patch for 3.20 (getting those
dependencies building and keeping them building is a Good Thing), can we
hold off on the first patch until it's not broken? Having an unconditional
depends on BROKEN isn't really that useful.

Cheers,

Will
