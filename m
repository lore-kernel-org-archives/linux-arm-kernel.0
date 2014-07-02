From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 02 Jul 2014 16:23:35 +0200
Subject: [GIT PULL FOR v3.17] Renesas CMT, MTU2 and TMU timers DT support
In-Reply-To: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1402931251-22581-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <2296815.Nb0BXfBtnT@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Could you please merge pull the following changes for v3.17 ? They have 
previously been posted as "[PATCH v4] Renesas CMT, MTU2 and TMU timers DT 
support". The only change compared to that version is a rebase on top of 
v3.16-rc3.

As last time I have board and SoC changes that depend on the driver changes 
and that will need to go through Simon's tree. Could you thus please provide a 
stable branch based on one of the v3.16-rc tags ?

The following changes since commit 4c834452aad01531db949414f94f817a86348d59:

  Linux 3.16-rc3 (2014-06-29 14:11:36 -0700)

are available in the git repository at:

  git://linuxtv.org/pinchartl/fbdev.git timers/upstream/drivers

for you to fetch changes up to 64a653a02e47e3cfdab45d0b52c4522a09bed590:

  clocksource: sh_mtu2: Add DT support (2014-07-02 16:01:53 +0200)

----------------------------------------------------------------
Laurent Pinchart (10):
      clocksource: sh_cmt: Drop support for legacy platform data
      clocksource: sh_cmt: Replace global spinlock with a per-device spinlock
      clocksource: sh_tmu: Drop support for legacy platform data
      clocksource: sh_tmu: Replace global spinlock with a per-device spinlock
      clocksource: sh_mtu2: Drop support for legacy platform data
      clocksource: sh_mtu2: Replace global spinlock with a per-device spinlock
      clocksource: shmobile: Remove unused sh_timer_config members
      clocksource: sh_cmt: Add DT support
      clocksource: sh_tmu: Add DT support
      clocksource: sh_mtu2: Add DT support

 Documentation/devicetree/bindings/timer/renesas,cmt.txt |  47 +++++
 .../devicetree/bindings/timer/renesas,mtu2.txt          |  39 ++++
 Documentation/devicetree/bindings/timer/renesas,tmu.txt |  39 ++++
 drivers/clocksource/sh_cmt.c                            | 233 ++++++---------
 drivers/clocksource/sh_mtu2.c                           | 146 +++++----------
 drivers/clocksource/sh_tmu.c                            | 127 ++++++-------
 include/linux/sh_timer.h                                |   5 -
 7 files changed, 309 insertions(+), 327 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,cmt.txt
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,mtu2.txt
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,tmu.txt

-- 
Regards,

Laurent Pinchart
