From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 12 Aug 2015 16:51:27 -0500
Subject: [PATCH 0/3] Enable EHCI-platform driver for use with ACPI
Message-ID: <1439416290-21228-1-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set enables the USB on the ARM Juno development platform
when using an ACPI kernel. This patch is in two primary parts. First
It tweaks the code in acpi_check_dma() to support the recently added
CCA attribute which describes a device which is not cache coherent.

It then adds an error message if the device cannot be configured with
the current DMA settings, finally it adds the ACPI PNP id to the
acpi_match_table entry.

Jeremy Linton (3):
  Honor ACPI _CCA attribute setting
  Display a DMA error message
  Add ACPI bindings for the EHCI platform driver.

 drivers/usb/host/ehci-platform.c | 13 ++++++++++++-
 include/acpi/acpi_bus.h          |  5 +++--
 2 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.4.3
