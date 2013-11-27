From: balbi@ti.com (Felipe Balbi)
Date: Wed, 27 Nov 2013 13:06:44 -0600
Subject: [PATCH 00/13] mfd: menelaus: a few cleanups
Message-ID: <1385579217-20127-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

few cleanups on the old menelaus driver. I don't have
HW to test these patches, maybe Aaro can help here ?

cheers

Felipe Balbi (13):
  mfd: menelaus: drop __exit section annotation
  mfd: menelaus: switch over to module_i2c_driver
  mfd: menelaus: convert to threaded irq
  mfd: menelaus: remove unnecessary loop
  mfd: menelaus: use for_each_set_bit()
  mfd: menelaus: pass menelaus pointer as argument to enable/disable irq
  mfd: menelaus: limit the usage of the_menelaus
  mfd: menelaus: pass menelaus_chip pointer to add/remove irq functions
  mfd: menelaus: pass menelaus_chip pointer to get/set voltage
  mfd: menelaus: pass menelaus_chip argument to menelaus <-> time
    helpers
  mfd: menelaus: start to use irqdomain
  mfd: menelaus: switch all children to threaded_irq
  mfd: menelaus: remove unnecessary definition

 drivers/mfd/menelaus.c | 616 +++++++++++++++++++++++++------------------------
 1 file changed, 319 insertions(+), 297 deletions(-)

-- 
1.8.4.GIT
