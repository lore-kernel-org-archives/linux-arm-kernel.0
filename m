From: robherring2@gmail.com (Rob Herring)
Date: Wed, 25 May 2011 16:31:11 -0500
Subject: [RFC PATCH v3 0/2] amba bus device tree probing
Message-ID: <1306359073-16274-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This is updated amba bus DT probe support. It has changed significantly since
v2 based on the discussion and the conclusions from that discussion:

- The Linux amba_bus is really for ARM Primecell peripherals, not a type of bus.
- The amba_bus is not going to be replaced by platform_bus.

The bus scanning is done entirely by of_platform_bus_populate/probe and only
the device creation is handled by the amba bus code. This patch set can support
Grant's options 2 or 3 depending on the match table used.

Applies to devicetree/next on git://git.secretlab.ca/git/linux-2.6

Rob

Rob Herring (2):
  drivers/amba: create devices from device tree
  dt: add custom device creation to platform bus scan

 drivers/amba/bus.c          |   51 +++++++++++++++++++++++++++++++++++++++++++
 drivers/of/platform.c       |   27 ++++++++++++++++------
 include/linux/amba/bus.h    |    5 ++++
 include/linux/of_platform.h |   11 ++++++--
 4 files changed, 83 insertions(+), 11 deletions(-)

-- 
1.7.4.1
