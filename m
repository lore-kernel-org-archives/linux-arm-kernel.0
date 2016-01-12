From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 12 Jan 2016 16:17:54 +0100
Subject: [PATCHv2 0/2] net: fec: Reset ethernet PHY whenever the enet_out
 clock is being enabled
Message-ID: <1452611876-451-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes a regression introduced by
commit e8fcfcd5684a ("net: fec: optimize the clock management to save power")
for ethernet PHYs that are using ENET_OUT as reference clock (on i.MX6 or i.MX28)

Changes vs. v1:
- fixed reference to the commit that introduced the regression.
- dropped patch to use gpiod framework. This should be added later,
  after the affected DTBs have been updated to specify the correct
  gpio_flags.

Patch overview:
1. cleanup patch to remove redundant NULL checks
2. call fec_reset_phy() after the ENET_OUT clock has been enabled
