From: weber@corscience.de (Thomas Weber)
Date: Tue, 18 Jan 2011 07:58:50 +0100
Subject: [PATCHv3 0/2] omap3: Devkit8000: misc fixes
Message-ID: <1295333932-23935-1-git-send-email-weber@corscience.de>
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

Changes from v2:
	Better comment for removing low level functions used for twl4030 gpio
	Fix indention => indentation in comment

Daniel Morsing (1):
  OMAP3: Devkit8000: Fix tps65930 pullup/pulldown configuration

Thomas Weber (1):
  OMAP3: Devkit8000: Change lcd power pin

 arch/arm/mach-omap2/board-devkit8000.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

-- 
1.7.4.rc2
