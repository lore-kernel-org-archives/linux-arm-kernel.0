From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Wed, 30 Jun 2010 17:28:00 +0300
Subject: [RFC][PATCH 0/1] ARM: Add initial hibernation support
Message-ID: <1277908081-17195-1-git-send-email-Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the experimental patch to add hibernation (a.k.a:
Suspend-To-Disk) support for ARM architecutre.

Presently it seems to work with OMAP3, and apparently it still needs
more efforts to make it enough stable and to support other ARM
platforms cleanly but I am sending this patch to get some feedbacks at
its early phase to find out the further direction. It would be really
appreciated if you give some comment on this.

This patch is based on the one sent to loml(*1) by Teerth Reddy, which
was originally from Romit and Raghu at TI.

    *1: https://patchwork.kernel.org/patch/96442/

Hiroshi DOYU (1):
  ARM: Add initial hibernation support

 arch/arm/Kconfig                |    4 +
 arch/arm/include/asm/memory.h   |    1 +
 arch/arm/include/asm/suspend.h  |    6 +
 arch/arm/kernel/Makefile        |    1 +
 arch/arm/kernel/hibernate.c     |  234 +++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/hibernate_asm.S |  135 ++++++++++++++++++++++
 arch/arm/kernel/vmlinux.lds.S   |    3 +-
 7 files changed, 383 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/include/asm/suspend.h
 create mode 100644 arch/arm/kernel/hibernate.c
 create mode 100644 arch/arm/kernel/hibernate_asm.S
