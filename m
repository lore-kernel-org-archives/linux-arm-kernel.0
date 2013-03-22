From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 22 Mar 2013 09:23:01 -0300
Subject: [PATCH for 3.9 0/2] thermal: Marvell SoC thermal formula fixes
Message-ID: <1363954983-30822-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a small patchset that fixes thermal sensor formulas for Kirkwood
and Dove thermal driver. The old formulas had been taken from 88AP510 public
datasheets which appears to be slightly wrong.

The current formula comes from Marvell internal documentation
and has been confirmed by Lior Amsalem.

This has been tested on a Kirkwood board (Openblocks A6) only.
If at all possible, I would like to have the Dove fix tested
before this is merged.

Please note that this fix was previously part of a bigger thermal
patchset [1]. I've taken this out so it can be applied on v3.9 first.

[1] http://www.spinics.net/lists/arm-kernel/msg231697.html

Ezequiel Garcia (2):
  thermal: kirkwood: Fix thermal sensor formula
  thermal: dove: Fix thermal sensor formula

 drivers/thermal/dove_thermal.c     |    7 ++++---
 drivers/thermal/kirkwood_thermal.c |    8 ++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

-- 
1.7.8.6
