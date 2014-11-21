From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 21 Nov 2014 14:35:28 +0800
Subject: [PATCH v3 0/3] ARM: kprobes: introduces instruction checker.
Message-ID: <1416551731-50777-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This the third version (and the final version I hope) of instruction
checker patch. It is a part of version 10 of ARM OPTPROBE patch series.
Previous discussion can be found from:

https://lkml.org/lkml/2014/11/18/26
https://lkml.org/lkml/2014/10/25/48
https://lkml.org/lkml/2014/10/22/254
https://lkml.org/lkml/2014/8/27/255
https://lkml.org/lkml/2014/8/12/12
https://lkml.org/lkml/2014/8/8/992
https://lkml.org/lkml/2014/8/8/5
https://lkml.org/lkml/2014/8/5/63

Except fixing an error found by Tixy, the main changes in this series
are mainly small code cleanup and commit message cleanup.

Wang Nan (3):
  ARM: kprobes: introduces checker
  ARM: kprobes: collects stack consumption for store instructions
  ARM: kprobes: disallow probing stack consuming instructions

 arch/arm/include/asm/kprobes.h           |   1 -
 arch/arm/include/asm/probes.h            |  13 ++++
 arch/arm/kernel/Makefile                 |   6 +-
 arch/arm/kernel/entry-armv.S             |   3 +-
 arch/arm/kernel/kprobes-arm.c            |   3 +
 arch/arm/kernel/kprobes-test-arm.c       |  16 +++--
 arch/arm/kernel/kprobes-thumb.c          |   4 ++
 arch/arm/kernel/kprobes.c                |  15 ++++-
 arch/arm/kernel/kprobes.h                |   7 +-
 arch/arm/kernel/probes-arm.c             |   5 +-
 arch/arm/kernel/probes-arm.h             |   3 +-
 arch/arm/kernel/probes-checkers-arm.c    |  99 +++++++++++++++++++++++++++++
 arch/arm/kernel/probes-checkers-common.c |  87 +++++++++++++++++++++++++
 arch/arm/kernel/probes-checkers-thumb.c  | 106 +++++++++++++++++++++++++++++++
 arch/arm/kernel/probes-checkers.h        |  53 ++++++++++++++++
 arch/arm/kernel/probes-thumb.c           |  10 +--
 arch/arm/kernel/probes-thumb.h           |   6 +-
 arch/arm/kernel/probes.c                 |  70 ++++++++++++++++++--
 arch/arm/kernel/probes.h                 |  11 +++-
 arch/arm/kernel/uprobes.c                |   2 +-
 20 files changed, 489 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm/kernel/probes-checkers-arm.c
 create mode 100644 arch/arm/kernel/probes-checkers-common.c
 create mode 100644 arch/arm/kernel/probes-checkers-thumb.c
 create mode 100644 arch/arm/kernel/probes-checkers.h

-- 
1.8.4
