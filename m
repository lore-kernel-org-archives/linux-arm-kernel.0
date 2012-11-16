From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 16 Nov 2012 11:41:43 +0000
Subject: [RFC PATCH v2 0/2] ARM: cpuinfo update for heterogeneous systems
Message-ID: <1353066105-19486-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series provides an update of the current information available
in the kernel through /proc/cpuinfo file interface. It extends the current
code so that the HW info of all online CPUs are printed at once when the file
is read.

v1 available here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-October/125905.html

Changes in v2:

- split the set in two logical patches since the stashing of MIDR can be
  reused by other patchsets coming, and it is a change that stands on its own.

Lorenzo Pieralisi (2):
  ARM: kernel: add MIDR to per-CPU information data
  ARM: kernel: update cpuinfo to print all online CPUs features

 arch/arm/include/asm/cpu.h |  1 +
 arch/arm/kernel/setup.c    | 66 +++++++++++++++++++++++-----------------------
 arch/arm/kernel/smp.c      |  1 +
 3 files changed, 35 insertions(+), 33 deletions(-)

-- 
1.7.12
