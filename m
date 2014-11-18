From: wangnan0@huawei.com (Wang Nan)
Date: Tue, 18 Nov 2014 14:32:37 +0800
Subject: [PATCH v8 0/2] ARM: kprobes: enable OPTPROBES for ARM32
Message-ID: <1416292359-75893-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable OPTPROBES for ARM 32. Previous discussion can be found:

https://lkml.org/lkml/2014/10/25/48
https://lkml.org/lkml/2014/10/22/254
https://lkml.org/lkml/2014/8/27/255
https://lkml.org/lkml/2014/8/12/12
https://lkml.org/lkml/2014/8/8/992
https://lkml.org/lkml/2014/8/8/5
https://lkml.org/lkml/2014/8/5/63

This series of patches is depend on 'ARM: kprobes: introduces
instruction checker.', which can be found at:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/303525.html

Wang Nan (2):
  kprobes: copy ainsn after alloc aggr kprobe
  ARM: kprobes: enable OPTPROBES for ARM 32

 arch/arm/Kconfig                  |   1 +
 arch/arm/include/asm/kprobes.h    |  26 ++++
 arch/arm/kernel/Makefile          |   3 +-
 arch/arm/kernel/kprobes-opt-arm.c | 285 ++++++++++++++++++++++++++++++++++++++
 kernel/kprobes.c                  |   6 +
 5 files changed, 320 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/kernel/kprobes-opt-arm.c

-- 
1.8.4
