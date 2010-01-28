From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 28 Jan 2010 14:59:25 -0800
Subject: [RFC PATCH 00/12] generic arm for msm -v2
Message-ID: <1264719577-5436-1-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's another round of RFC patches. I've dropped several patches
that people objected to, and made some changes indicated by Russell
and others.

Hopefully this time these don't get held for moderator review.

Daniel Walker (3):
  arm: msm: allow ARCH_MSM to have v7 cpus
  arm: msm: add oprofile pmu support
  arm: boot: update old ARM ID

Dave Estes (2):
  arm: vfp: Add additional vfp interfaces
  arm: mm: qsd8x50: Fix incorrect permission faults

Larry Bassel (1):
  arm: msm: set L2CR1 to enable prefetch and burst on Scorpion.

Praveen Chidambaram (1):
  arm: msm: Enable frequency scaling.

Steve Muckle (3):
  arm: mm: retry on QSD icache parity errors
  arm: mm: support error reporting in L1/L2 caches on QSD
  arm: msm: define HAVE_CLK for ARCH_MSM

Willie Ruan (2):
  arm: mm: cache-l2x0: add l2x0 suspend and resume functions
  arm: mm: enable L2X0 to use L2 cache on MSM7X27

 arch/arm/Kconfig                           |   20 +++++++++---
 arch/arm/boot/compressed/head.S            |    4 +-
 arch/arm/include/asm/hardware/cache-l2x0.h |    3 ++
 arch/arm/include/asm/vfp.h                 |    6 ++++
 arch/arm/mach-msm/Kconfig                  |    2 +
 arch/arm/mm/Kconfig                        |   13 +++++++-
 arch/arm/mm/abort-ev7.S                    |   38 +++++++++++++++++++++++
 arch/arm/mm/cache-l2x0.c                   |   46 ++++++++++++++++++++++++++++
 arch/arm/mm/fault.c                        |   36 +++++++++++++++++++++-
 arch/arm/mm/proc-v7.S                      |   13 ++++++++
 arch/arm/oprofile/op_model_v6.c            |    2 +
 arch/arm/vfp/vfpmodule.c                   |   37 +++++++++++++++++-----
 12 files changed, 202 insertions(+), 18 deletions(-)
