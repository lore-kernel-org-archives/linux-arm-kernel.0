From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 4 Mar 2014 14:48:08 +0200
Subject: [PATCH v3 0/5] drivers: bus: omap_l3: Conversion to devm_*
Message-ID: <1393937293-6036-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes since v2:
Comments from Alexander Shiyan addressed:
- Do not check the return of platform_get_resource() - no need to do that
- Use devm_ioremap_resource() instead devm_request_and_ioremap()

Changes since v1:
- Fixed Santosh's email address in the commit messages.

Cleanup of platform probe and remove (removing the remove function at the end)
with converting the driver to use the devm_* versions kzalloc, ioremap and
request_irq. 

This is a resend of an old series which I found when doing some spring cleanup
on my HDD:
http://www.spinics.net/lists/linux-omap/msg90531.html

Regards,
Peter
---
Peter Ujfalusi (5):
  drivers: bus: omap_l3: Convert to use devm_kzalloc
  drivers: bus: omap_l3: Convert to use devm_ioremap_resource()
  drivers: bus: omap_l3: Convert to use devm_request_irq()
  drivers: bus: omap_l3: Remove the platform driver's remove function
  drivers: bus: omap_l3: Change pr_crit() to dev_err() when IRQ request
    fails

 drivers/bus/omap_l3_noc.c | 102 +++++++++-------------------------------------
 1 file changed, 20 insertions(+), 82 deletions(-)

-- 
1.9.0
