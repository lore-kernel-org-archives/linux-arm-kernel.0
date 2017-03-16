From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 16 Mar 2017 17:05:40 +0000
Subject: [PATCH 0/2] irqchip/gic-v3-its: LPI tables fixes
Message-ID: <20170316170542.3568-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By staring at the code (while writing the ITS driver for Xen) I
stumbled upon two minor things that deserve fixing:
Patch 1 checks whether LPIs are really disabled before setting up the
tables, as the architecture actually disallows clearing the LPI enable
bit. We try this anyway, but bail out if this fails.
Patch 2 makes sure we don't miss when the redistributors denies our
cacheable mapping request.

Please have a look and apply if that makes sense.

Cheers,
Andre.

Andre Przywara (2):
  irqchip/gic-v3-its: bail out on already enabled LPIs
  irqchip/gic-v3-its: always check for cacheability attributes

 drivers/irqchip/irq-gic-v3-its.c | 41 ++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

-- 
2.9.0
