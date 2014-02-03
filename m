From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  3 Feb 2014 17:37:20 +0100
Subject: [PATCH 0/3] ARM: v7m: updates for 3.15
Message-ID: <1391445443-28971-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

I'd like these three patches to go in during the 3.15 merge window. The
first two were already send earlier on this list (Message-Id:
20131210212550.GF18888 at pengutronix.de), I only squashed in a fix for a format
warning and an unused variable warning into the 2nd. The third is a trivial
patch to allow power management on v7-M.

The series is available in my repository in the v7m branch:

	git://git.pengutronix.de/git/ukl/linux.git v7m

If you are ok with the changes, tell how you want them to pick up:
signed tag to pull, patch system, pull as is, ...

Also I wonder if you still have 7889/1 on your radar, I expected it to
go in for 3.14-rc1. Is it just -ENOTIME on your side, or do you have any
concerns?

Best regards
Uwe

Uwe Kleine-K?nig (3):
  ARM: make isa_mode macro more robust and fix for v7-M
  ARM: show_regs: on v7-M there are no FIQs, different processor modes,
    ...
  ARM: v7m: add trivial suspend support

 arch/arm/Kconfig              | 2 +-
 arch/arm/include/asm/ptrace.h | 8 ++++++--
 arch/arm/kernel/process.c     | 5 +++++
 3 files changed, 12 insertions(+), 3 deletions(-)

-- 
1.8.5.3
