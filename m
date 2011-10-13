From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Oct 2011 15:27:54 -0700
Subject: [GIT PULL] Please pull tegra cleanups for 3.2
In-Reply-To: <201110131716.18358.arnd@arndb.de>
References: <CAOesGMjVAJK2ArOdpYNmKa11vqCfppi8Ofc0qGn4WxuMxLvd_Q@mail.gmail.com>
	<201110131716.18358.arnd@arndb.de>
Message-ID: <CAOesGMh9OSKpggk2d4PUwKsQwgYcpiO9rc3ukdp2s4X13djT=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 13, 2011 at 8:16 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 13 October 2011, Olof Johansson wrote:
>> Hi Arnd,
>>
>> Please pull the below branch of cleanups for the 3.2 merge window.
>> They have been included in linux-next for a couple of days already.
>
> I saw Russell had a comment on the macro name should be addressed.
> I've put your series plus an additional commit to fix this up
> into the tegra/cleanup branch. When you ack this patch, I'll include
> this branch into next/cleanup and the for-next branch.

Based on discussion on IRC, I pulled in the edit into the original
commit instead and rebased the branch.

I also added the devices.c fix that I posted yesterday, so here is a
new pull request.


Thanks!

-Olof


The following changes since commit 976d167615b64e14bc1491ca51d424e2ba9a5e84:

  Linux 3.1-rc9 (2011-10-04 18:11:50 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git for-3.2/cleanup

Olof Johansson (15):
      ARM: tegra: annotate IO_*_VIRT pointers
      ARM: tegra: timer: don't cast __iomem pointers
      ARM: tegra: tegra2_clocks: don't cast __iomem pointers
      ARM: tegra: tegra2_clocks: 0 -> NULL changes
      ARM: tegra: pcie: don't cast __iomem pointers
      ARM: tegra: pcie: include board.h
      ARM: tegra: pcie: 0 -> NULL changes
      ARM: tegra: tegra_init_cache should be static
      ARM: tegra: tegra_rtc_read_ms should be static
      ARM: tegra: tegra_powergate_is_powered should be static
      ARM: tegra: tegra2_clocks: don't export some tables
      ARM: tegra: dma: staticify some tables and functions
      ARM: tegra: cpu-tegra: sparse type fix
      ARM: tegra: cpu-tegra: unexport two functions
      ARM: tegra: devices.c should include devices.h

 arch/arm/mach-tegra/common.c                 |    2 +-
 arch/arm/mach-tegra/cpu-tegra.c              |    6 ++--
 arch/arm/mach-tegra/devices.c                |    2 +
 arch/arm/mach-tegra/dma.c                    |   14 +++++---
 arch/arm/mach-tegra/include/mach/io.h        |   18 ++++++---
 arch/arm/mach-tegra/include/mach/powergate.h |    1 -
 arch/arm/mach-tegra/io.c                     |    8 ++--
 arch/arm/mach-tegra/pcie.c                   |    8 +++--
 arch/arm/mach-tegra/powergate.c              |    5 +--
 arch/arm/mach-tegra/tegra2_clocks.c          |   50 +++++++++++++-------------
 arch/arm/mach-tegra/timer.c                  |    6 ++--
 11 files changed, 66 insertions(+), 54 deletions(-)
