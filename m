From: rogerq@ti.com (Roger Quadros)
Date: Wed, 4 Dec 2013 13:34:30 +0200
Subject: [PATCH 0/1] gpio: twl4030: gpio LED regression fix for 3.13 rc
Message-ID: <1386156871-7639-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Commit 0b2aa8be that went into 3.13-rc2 introduced a regression
that causes failure in setting LED GPO direction to OUT.

This causes USB Host to fail probe on Beagleboard.

The following patch fixes this issue.

I've tried to higlight the issue in the original patch here
http://www.spinics.net/lists/linux-omap/msg100858.html

cheers,
-roger

Roger Quadros (1):
  gpio: twl4030: Fix regression for twl gpio LED output

 drivers/gpio/gpio-twl4030.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
1.8.3.2
