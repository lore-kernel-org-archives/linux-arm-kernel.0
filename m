From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Mon, 19 Oct 2015 22:37:59 +0300
Subject: [BISECTED] Nokia 770 framebuffer breakage
Message-ID: <20151019193759.GE31069@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Somewhere between 4.1 .. 4.3-rc6 framebuffer on Nokia 770 stopped working.

Bisection points to:

commit 2568999835d7797afce3dcc3a3f368051ffcaf1f
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Mon Mar 2 15:40:29 2015 +0000

    clkdev: add clkdev_create() helper

The commit cannot be reverted cleanly from current trees, but I re-tested
that commit 2568999835d7797afce3dcc3a3f368051ffcaf1f does not work and
commit 2568999835d7797afce3dcc3a3f368051ffcaf1f^1 indeed works.

A.
