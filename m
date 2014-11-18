From: wangnan0@huawei.com (Wang Nan)
Date: Tue, 18 Nov 2014 14:19:39 +0800
Subject: [PATCH v2 0/3] ARM: kprobes: introduces instruction checker.
Message-ID: <1416291582-74982-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is part of version 8 of 'ARM: kprobes: enable OPTPROBES for ARM32'.
Its main goal is introducing checker mechanism to give a chance to
detail check each probed instructions. Different from previous version,
this series redesign stack checker following Tixy's advise:
https://lkml.org/lkml/2014/10/27/662

Previous discussion can be found in following threads:

https://lkml.org/lkml/2014/10/25/48
https://lkml.org/lkml/2014/10/22/254
https://lkml.org/lkml/2014/8/27/255
https://lkml.org/lkml/2014/8/12/12
https://lkml.org/lkml/2014/8/8/992
https://lkml.org/lkml/2014/8/8/5
https://lkml.org/lkml/2014/8/5/63

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
 arch/arm/kernel/probes-checkers-arm.c    |  99 ++++++++++++++++++++++++++++
 arch/arm/kernel/probes-checkers-common.c |  87 +++++++++++++++++++++++++
 arch/arm/kernel/probes-checkers-thumb.c  | 108 +++++++++++++++++++++++++++++++
 arch/arm/kernel/probes-checkers.h        |  54 ++++++++++++++++
 arch/arm/kernel/probes-thumb.c           |  10 +--
 arch/arm/kernel/probes-thumb.h           |   6 +-
 arch/arm/kernel/probes.c                 |  61 ++++++++++++++++-
 arch/arm/kernel/probes.h                 |  11 +++-
 arch/arm/kernel/uprobes.c                |   2 +-
 20 files changed, 488 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/kernel/probes-checkers-arm.c
 create mode 100644 arch/arm/kernel/probes-checkers-common.c
 create mode 100644 arch/arm/kernel/probes-checkers-thumb.c
 create mode 100644 arch/arm/kernel/probes-checkers.h

-- 
1.8.4
