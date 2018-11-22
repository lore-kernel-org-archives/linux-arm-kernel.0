From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu, 22 Nov 2018 22:22:10 +0100
Subject: [PATCH 0/2] Link consumer with clock driver
Message-ID: <20181122212212.16039-1-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

While working on suspend to RAM feature, I ran into troubles multiple
times when clocks where not suspending/resuming at the desired time. I
had a look at the core and I think the same logic as in the
regulator's core may be applied here to (very easily) fix this issue:
using device links.

The only additional change I had to do was to always (when available)
populate the device entry of the core clock structure so that it could
be used later. This is the purpose of patch 1. Patch 2 actually adds
support for device links.

As I am not used to hack into the clock subsystem I might have missed
something big preventing such change but so far I could not see
anything wrong with it. As this touches core code, I am of course
entirely open to suggestions.

Thanks,
Miqu?l


Miquel Raynal (2):
  clk: core: clarify the check for runtime PM
  clk: core: link consumer with clock driver

 drivers/clk/clk.c            | 31 +++++++++++++++++++++++++------
 drivers/clk/clkdev.c         | 13 ++++++++++---
 include/linux/clk-provider.h |  2 ++
 3 files changed, 37 insertions(+), 9 deletions(-)

-- 
2.19.1
