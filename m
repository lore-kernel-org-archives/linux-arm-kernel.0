From: robherring2@gmail.com (Rob Herring)
Date: Thu, 19 May 2011 13:28:22 -0500
Subject: [PATCH v2 0/2] amba bus device tree probing
Message-ID: <1305829704-11774-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Grant,

Here's updated patches for amba bus probing. I folded my changes into Jeremy's
original patch.

The 1st patch works around an problem where you get multiple parent devices
created for the amba bus node. My fix seems like a lot of overhead, so perhaps
you have a better way to suggest.

Applies to devicetree/next on git://git.secretlab.ca/git/linux-2.6

Rob

Rob Herring (2):
  dt: check for devices already created fron DT scan
  drivers/amba: probe via device tree

 drivers/amba/bus.c       |  133 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/of/platform.c    |    8 +++
 include/linux/amba/bus.h |    7 +++
 3 files changed, 148 insertions(+), 0 deletions(-)

-- 
1.7.4.1
