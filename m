From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 31 May 2014 16:01:34 +0200
Subject: [PATCH v2 0/5] pinctrl: sunxi: Fix level triggered interrupt support
Message-ID: <1401544899-405-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is v2 of my patch-series to fix the level triggered interrupt support
for sunxi pinctrl. I've decided to make this a separate series now, rather then
keep posting it as part of the sdio oob irq series for easier tracking.

Note this series is based on top of pinctrl-next + Maxmime's
"[PATCH v2 0/5] pinctrl: sunxi: Add A31 external interrupts support" series,
since the 2 series conflict I thought it would be best to just do my series
on top.

Changes since v1:
-Dropped the pinctrl: sunxi: create irq/pin mapping during init patch,
 as this is in pinctrl-next now
-Added "pinctrl: sunxi: Fix sunxi_irq_cfg_reg not working for irqs >= 8"
 patch, this fixes a regression caused by Maxmime's set and should probably
 be squashed into Maxime's "pinctrl: sunxi: Implement multiple interrupt banks support"
 patch
-Dropped the setting of the irq_chip name from:
 "pinctrl: sunxi: Add IRQCHIP_SKIP_SET_WAKE flag for pinctrl irq chip"
-Use irq_request_resources callback in:
 "pinctrl: sunxi: Move setting of mux to irq type from unmask to request_resources"
-Rebased on top of Maxime's series

Regards,

Hans
