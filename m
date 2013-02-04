From: will.deacon@arm.com (Will Deacon)
Date: Mon,  4 Feb 2013 13:55:29 +0000
Subject: [GIT PULL 2/4] ARM broadcast timer updates for 3.9
In-Reply-To: <1359986131-13034-1-git-send-email-will.deacon@arm.com>
References: <1359986131-13034-1-git-send-email-will.deacon@arm.com>
Message-ID: <1359986131-13034-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

This is the second part of the kvm-related series and moves ARM over to
the generic timer broadcast implementation, currently queued by tglx in
-tip.

Please note that, due to this dependency, this branch contains mainline
up to ~-rc6, so you may want to keep it on a separate branch to avoid
pulling in a bunch of unrelated changes from -tip.

Thanks,

Will

--->8

The following changes since commit 04c2eee5b9dfcb13f3cd07a5537fb8c785f2751a:

  Merge branch 'x86-efi-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2013-01-31 17:10:36 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/broadcast

for you to fetch changes up to 5b91ab0abc957145c3ff6be03eb9a3901797019f:

  Merge branch 'clocks/broadcast-arm' of git://linux-arm.org/linux-mr into for-rmk/broadcast (2013-02-01 10:17:57 +0000)

----------------------------------------------------------------

Mark Rutland (4):
      clockevents: Add generic timer broadcast receiver
      clockevents: Add generic timer broadcast function
      arm: Use generic timer broadcast receiver
      arm: Add generic timer broadcast support

Will Deacon (2):
      Merge branch 'timers/for-arm' of git://git.kernel.org/.../tip/tip into for-rmk/broadcast
      Merge branch 'clocks/broadcast-arm' of git://linux-arm.org/linux-mr into for-rmk/broadcast

 arch/arm/Kconfig             |  1 +
 arch/arm/kernel/smp.c        | 13 ++++---------
 include/linux/clockchips.h   |  9 +++++++++
 kernel/time/Kconfig          |  4 ++++
 kernel/time/tick-broadcast.c | 30 ++++++++++++++++++++++++++++++
 5 files changed, 48 insertions(+), 9 deletions(-)
