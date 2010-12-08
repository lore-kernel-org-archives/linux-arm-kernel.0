From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Tue,  7 Dec 2010 20:28:15 -0800
Subject: [PATCH v2 0/6] SMP support for msm
Message-ID: <1291782501-3909-1-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for SMP on msm targets, and specifically adds
support for SMP on the msm8x60.

Jeff Ohlstein (4):
  arm: dma-mapping: move consistent_init to early_initcall
  msm: timer: SMP timer support for msm
  msm: hotplug: support cpu hotplug on msm
  msm: add SMP support for msm

Stepan Moskovchenko (1):
  msm: scm-boot: Support for setting cold/warm boot addresses

Stephen Boyd (1):
  msm: Secure Channel Manager (SCM) support

 arch/arm/mach-msm/Kconfig                       |    5 +
 arch/arm/mach-msm/Makefile                      |    4 +
 arch/arm/mach-msm/headsmp.S                     |   43 ++++
 arch/arm/mach-msm/hotplug.c                     |  103 +++++++++
 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h |    6 +-
 arch/arm/mach-msm/include/mach/smp.h            |    2 +
 arch/arm/mach-msm/io.c                          |    1 +
 arch/arm/mach-msm/platsmp.c                     |  146 ++++++++++++
 arch/arm/mach-msm/scm-boot.c                    |   39 +++
 arch/arm/mach-msm/scm-boot.h                    |   38 +++
 arch/arm/mach-msm/scm.c                         |  280 +++++++++++++++++++++++
 arch/arm/mach-msm/scm.h                         |   41 ++++
 arch/arm/mach-msm/timer.c                       |  130 +++++++++--
 arch/arm/mm/dma-mapping.c                       |    2 +-
 14 files changed, 817 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm/mach-msm/headsmp.S
 create mode 100644 arch/arm/mach-msm/hotplug.c
 create mode 100644 arch/arm/mach-msm/platsmp.c
 create mode 100644 arch/arm/mach-msm/scm-boot.c
 create mode 100644 arch/arm/mach-msm/scm-boot.h
 create mode 100644 arch/arm/mach-msm/scm.c
 create mode 100644 arch/arm/mach-msm/scm.h

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
