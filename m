From: balbi@ti.com (Felipe Balbi)
Date: Wed, 17 Oct 2012 18:33:58 +0300
Subject: [RFC/NOT FOR MERGING 0/5] OMAP PM patches
Message-ID: <1350488043-5053-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

this series is actually *REALLY* far from ready, but I wanted
to ask if I should continue down this track because it really
looks (to me at least) that OMAP's PM layer took a few uneecessary
shortcuts.

I'm trying to understand the reasoning behind that, so bear with
me for a while.

At least patches 1 and 4 look like they could go upstream, but
please give it a very good review. I will continue to work on
these if the rest of the community thinks it's valid, otherwise
I would like to get some explanation for the way OMAP PM layer
is implemented today.

cheers

Felipe Balbi (5):
  arm: omap: fix up _od_suspend_noirq and _od_resume_noirq
  arm: omap: don't forcefully runtime suspend a device
  arm: omap: introduce other PM methods
  i2c: omap: don't re-enable IRQs after masking them
  i2c: omap: introduce suspend/resume methods

 arch/arm/plat-omap/omap_device.c | 162 +++++++++++++++++++++++++++++++++++++--
 drivers/i2c/busses/i2c-omap.c    |  70 ++++++++++++-----
 2 files changed, 207 insertions(+), 25 deletions(-)

-- 
1.8.0.rc0
