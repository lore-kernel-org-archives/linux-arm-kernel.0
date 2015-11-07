From: lho@apm.com (Loc Ho)
Date: Fri,  6 Nov 2015 17:51:57 -0700
Subject: [PATCH v3 0/2] acpi: apei: Bug fix to enable APEI support for ARMv8
Message-ID: <1446857519-5908-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3
* Change the title of the patch to reflect the patch
* Completely dropped the driver. Instead, move completely to the FW by
  accessing the GIC directly.
* Fix a bug with function acpi_gsi_to_irq
* Enable APEI multiple GHES source to share an single external IRQ

v2
* Make all code more generic naming
* Still waiting for comment from Linaro folks on APEI

---
Loc Ho (2):
  acpi: Fix proper return code for function acpi_gsi_to_irq
  acpi: apei: Enable APEI multiple GHES source to share an single
    external IRQ

 drivers/acpi/apei/ghes.c |    2 +-
 drivers/acpi/gsi.c       |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
