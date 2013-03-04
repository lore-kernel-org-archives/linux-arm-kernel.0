From: hechtb@gmail.com (Bastian Hecht)
Date: Mon,  4 Mar 2013 18:54:04 +0100
Subject: [PATCH] Core Standby Mode and caches
Message-ID: <1362419645-3116-1-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

here a patch that adds Core Standby Mode.
The code as it is works fine, but still I've got a question:

The datasheet of the r8a7740 states that caches are kept in a standby state.
Still I have to issue a outer_flush_all() to flush the L2 before sleeping. If
I don't do it the SoC hangs or sometimes jumps to the boot code
Booting Linux on physical CPU 0x0...

Do we have an explanation for that? Do we want one? Do we need one?

Further this is the dozenth incarnation of v7_invalidate_l1. I don't want to
compile in headsmp.S as this is a uniprocessor system. On the other hand I'm a
bit reluctant to be the one moving it into the general ARM code base - doing
something wrong there would raise eternal hatred of many people.


The patch is based on topic/all+next (a9043db17d02119bcda8a33414e7526961a7cee5)

Cheers,

 Bastian

Bastian Hecht (1):
  ARM: shmobile: r8a7740: Add CPU Core Standby Mode

 arch/arm/mach-shmobile/Makefile              |    2 +-
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/pm-r8a7740.c          |   63 +++++++++++++++++++++-
 arch/arm/mach-shmobile/sleep-r8a7740.S       |   75 ++++++++++++++++++++++++++
 4 files changed, 138 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/sleep-r8a7740.S

-- 
1.7.9.5
