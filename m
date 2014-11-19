From: wangnan0@huawei.com (Wang Nan)
Date: Wed, 19 Nov 2014 14:50:42 +0800
Subject: [PATCH v9 0/2] ARM: kprobes: enable OPTPROBES for ARM32
Message-ID: <1416379844-25160-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 9 of OPTPROBES for ARM 32. Previous discussion can be
found from:

https://lkml.org/lkml/2014/11/18/41
https://lkml.org/lkml/2014/10/25/48
https://lkml.org/lkml/2014/10/22/254
https://lkml.org/lkml/2014/8/27/255
https://lkml.org/lkml/2014/8/12/12
https://lkml.org/lkml/2014/8/8/992
https://lkml.org/lkml/2014/8/8/5
https://lkml.org/lkml/2014/8/5/63

The main change of this series is use Masami Hiramatsu's patch to avoid
copy_kprobes() twice. See: https://lkml.org/lkml/2014/11/18/1090 .

This series is depend on 'ARM: kprobes: introduces instruction
checker.' to collect stack consumption, which can be found at:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/303525.html

Masami Hiramatsu (1):
  kprobes: Pass the original kprobe for preparing optimized kprobe

Wang Nan (1):
  ARM: kprobes: enable OPTPROBES for ARM 32

 arch/arm/Kconfig                  |   1 +
 arch/arm/include/asm/kprobes.h    |  26 ++++
 arch/arm/kernel/Makefile          |   3 +-
 arch/arm/kernel/kprobes-opt-arm.c | 290 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/kprobes/opt.c     |   3 +-
 include/linux/kprobes.h           |   3 +-
 kernel/kprobes.c                  |   4 +-
 7 files changed, 325 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/kernel/kprobes-opt-arm.c

-- 
1.8.4
