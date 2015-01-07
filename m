From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 07 Jan 2015 01:17:29 -0700
Subject: [PATCH 0/2] arm64: first set of Kconfig patches for Tegra132 support
Message-ID: <20150107081638.14381.42444.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin & Will,

These patches start the ARM64 Kconfig and defconfig changes to
support the Tegra132 (aka Tegra K1 64-bit) SoC and the NVIDIA
Norrin64 FFD board.

Tegra132 support is made conditional on CONFIG_BROKEN, since
there are some patches pending for other maintainers to fix
compilation when CONFIG_ARCH_TEGRA is set during an ARM64 build.
Once those patches have been merged, a subsequent patch will be
sent to remove the CONFIG_BROKEN dependency and to make a few other
defconfig changes that are dependent on CONFIG_ARCH_TEGRA.

These patches apply on the arm64 fixes/core branch, commit
5d96e0cba263.  They have been boot-tested on QEMU 2.2.0 AArch64,
and (after other patches have been applied) have been boot-tested
on the Tegra132 Norrin64 FFD board.

A signed tag containing these patches is available at:

git://git.kernel.org/pub/scm/linux/kernel/git/pjw/tegra-pending tags/arm64-tegra132-kconfig-a-20150107


- Paul

---

Paul Walmsley (2):
      arm64: Kconfig: add basic support for the Tegra SoC family and the Tegra132 SoC
      arm64: defconfig: add some Kconfig entries used by Tegra132 Norrin FFD board


 arch/arm64/Kconfig           |   29 +++++++++++++++++++++++
 arch/arm64/configs/defconfig |   52 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 71 insertions(+), 10 deletions(-)

   text	   data	    bss	    dec	    hex	filename
7173728	 449984	 199064	 7822776 775db8	vmlinux.old
9435086	 626104	 220208	10281398 9ce1b6	vmlinux
