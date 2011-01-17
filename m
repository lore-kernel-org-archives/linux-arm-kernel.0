From: weber@corscience.de (Thomas Weber)
Date: Mon, 17 Jan 2011 15:11:57 +0100
Subject: [PATCHv2 0/2] misc Devkit8000 fixes
Message-ID: <1295273519-6189-1-git-send-email-weber@corscience.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is a set of misc fixes for the devkit8000.

The only really notable one is the lcd enable gpio fix. It gets rid
of some nasty low level twl4030 calls and replaces them with generic gpio
calls. It also fixes a bug where the screen would not turn off when
blanking.

Changes from v1: 
	Pull the indention fix into "Change lcd power pin".
	Change the pin for lcd pwren.
	Fix the pullup/pulldown configuration after lcd prwen correction.

Daniel Morsing (1):
  omap3: devkit8000: fix tps65930 pullup/pulldown configuration

Thomas Weber (1):
  OMAP3: Devkit8000: Change lcd power pin

 arch/arm/mach-omap2/board-devkit8000.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

-- 
1.7.4.rc2
