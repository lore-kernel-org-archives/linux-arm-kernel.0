From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 22 Aug 2011 20:22:20 +0200
Subject: [RFC PATCH 0/3] OMAP: omap_device: Add a method to build an
	omap_device from a DT node
Message-ID: <1314037343-19783-1-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

This is an initial attempt to use a notifier in order to create an
omap_device from a platform_device bound to DT node as suggested by Grant.
For the moment, the informations are all extracted from the hwmod data.
The idea is to focus first on the devices / board static init removal.
The other issue is that some bindings, like dma, are still not present
in the DT core code. The reg and irq bindings are there, but cannot
be used by some drivers due to the lack of named ressources in DT.
Since the DT core cannot change, the drivers will have to be modified
first.
In a second phase these informations will be moved from hwmod to DT.

Patches are based on my for_3.2/1_omap_device_cleanup branch and are
available here:
git://gitorious.org/omap-pm/linux.git for_3.2/2_omap_device_dt

It is tested on OMAP4 SDP and Panda.

Regards,
Benoit


Benoit Cousson (3):
  OMAP: omap_device: Add omap_device_[alloc|delete] for DT integration
  OMAP: omap_device: Add a DT parser for multiple strings
  OMAP: omap_device: Add a method to build an omap_device from a DT node

 arch/arm/plat-omap/omap_device.c |  309 +++++++++++++++++++++++++++++++-------
 1 files changed, 255 insertions(+), 54 deletions(-)
