From: govindraj.raja@ti.com (Govindraj.R)
Date: Mon, 9 May 2011 18:05:28 +0530
Subject: [PATCH 0/2 v2] OMAP2+: hwmod: Add hwmod's API's for pad wakeup
Message-ID: <1304944530-12998-1-git-send-email-govindraj.raja@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add two API's to set IO Pad wakeup capability based on hwmod
mux pins available and also to check the status of IO Pad wakeup
event.

This two patches are separated from uart_runtime patches posted
earlier and uart_runtime adaptation relies on these two API's.

Based on 2.6.39-rc6

Changes from v1:
---------------
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg49141.html

Reference to Discussion:
------------------------
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg49000.html
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg49001.html

Govindraj.R (2):
  OMAP2+: hwmod: Add API to enable IO ring wakeup.
  OMAP2+: hwmod: Add API to check IO PAD wakeup status

 arch/arm/mach-omap2/mux.c                     |   28 +++++++++++
 arch/arm/mach-omap2/mux.h                     |   13 +++++
 arch/arm/mach-omap2/omap_hwmod.c              |   65 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_device.h |    2 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    4 ++
 arch/arm/plat-omap/omap_device.c              |   50 +++++++++++++++++++
 6 files changed, 162 insertions(+), 0 deletions(-)
