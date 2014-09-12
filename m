From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 12 Sep 2014 11:32:57 +0100
Subject: [PATCH v8 6/8] drivers: cpuidle: CPU idle ARM64 driver
In-Reply-To: <54116C40.3080700@linaro.org>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1409585324-3678-7-git-send-email-lorenzo.pieralisi@arm.com>
 <20140903173740.GJ1824@e102568-lin.cambridge.arm.com>
 <20140904160320.GB22354@arm.com>
 <20140904172909.GA14822@e102568-lin.cambridge.arm.com>
 <20140905092120.GG13515@arm.com>
 <20140905153457.GA26306@e102568-lin.cambridge.arm.com>
 <54115D16.30206@linaro.org>
 <20140911085727.GA25773@e102568-lin.cambridge.arm.com>
 <54116C40.3080700@linaro.org>
Message-ID: <20140912103257.GB24416@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel, Lorenzo,

On Thu, Sep 11, 2014 at 10:32:48AM +0100, Daniel Lezcano wrote:
> On 09/11/2014 10:57 AM, Lorenzo Pieralisi wrote:
> > There is no ARM code in my series. So to sum it up:
> >
> > a) I send a pull request to Catalin for arm64 patches on top of the branch
> >     you are creating with my patches
>  >
> > b) You take care of merging the CPUidle related patches through your
> >     tree
> >
> > Is the above what you meant ?
> 
> Right, that allows to share a branch across the trees and resolve the 
> dependencies when a patchset is touching different subsystems.
> 
> I realize the dependency is inverted regarding what I proposed 
> initially, so it is up to Catalin to create the branch and I will share 
> it with him.

I created the branch below with the arm64 specific patches for cpuidle.
I won't rebase it and it should appear in -next tomorrow.

Lorenzo, please send a pull request to Daniel with the additional
patches on top of the arm64 branch. Thanks.

The following changes since commit 2ce7598c9a453e0acd0e07be7be3f5eb39608ebd:

  Linux 3.17-rc4 (2014-09-07 16:09:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/cpuidle

for you to fetch changes up to 18910ab0d916b1a87016d69efd027714a80521dd:

  arm64: add PSCI CPU_SUSPEND based cpu_suspend support (2014-09-12 10:48:56 +0100)

----------------------------------------------------------------
Lorenzo Pieralisi (4):
      Documentation: arm: define DT idle states bindings
      arm64: kernel: refactor the CPU suspend API for retention states
      arm64: kernel: introduce cpu_init_idle CPU operation
      arm64: add PSCI CPU_SUSPEND based cpu_suspend support

 Documentation/devicetree/bindings/arm/cpus.txt     |   8 +
 .../devicetree/bindings/arm/idle-states.txt        | 679 +++++++++++++++++++++
 Documentation/devicetree/bindings/arm/psci.txt     |  14 +-
 arch/arm64/include/asm/cpu_ops.h                   |   3 +
 arch/arm64/include/asm/cpuidle.h                   |  13 +
 arch/arm64/include/asm/suspend.h                   |   1 +
 arch/arm64/kernel/Makefile                         |   1 +
 arch/arm64/kernel/cpuidle.c                        |  31 +
 arch/arm64/kernel/psci.c                           | 104 ++++
 arch/arm64/kernel/sleep.S                          |  47 +-
 arch/arm64/kernel/suspend.c                        |  48 +-
 11 files changed, 916 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/idle-states.txt
 create mode 100644 arch/arm64/include/asm/cpuidle.h
 create mode 100644 arch/arm64/kernel/cpuidle.c

-- 
Catalin
