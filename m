From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Mon, 10 May 2010 19:49:52 +0200
Subject: [PATCH 0/3] mx31moboard OTG host support
Message-ID: <1273513795-28247-1-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

This patch set add the OTG host support for the eyebot robot.

The first patch fix the usb PHY reset so we really do reset and configure 
the pad pull-up/down so the signal are stable while applying the reset 
signal (observed with an oscilloscope).

The last two patches are adding a new number to the mx31moboard_baseboard 
bootparam so we can choose at boot if we want an usb device or host on the 
smartbot board.

Regards,
Philippe


Philippe Retornaz (3):
  mx31moboard: Fix usb PHY reset
  mx31moboard: Move usb OTG device registration
  mx31moboard: OTG host support for smartbot board

 arch/arm/mach-mx3/mach-mx31moboard.c               |  104 +++++++-------------
 arch/arm/mach-mx3/mx31moboard-devboard.c           |    9 ++
 arch/arm/mach-mx3/mx31moboard-marxbot.c            |    8 ++
 arch/arm/mach-mx3/mx31moboard-smartbot.c           |   42 ++++++++-
 arch/arm/plat-mxc/include/mach/board-mx31moboard.h |    3 +-
 5 files changed, 97 insertions(+), 69 deletions(-)
