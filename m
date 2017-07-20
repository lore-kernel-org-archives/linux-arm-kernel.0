From: lho@apm.com (Loc Ho)
Date: Thu, 20 Jul 2017 14:36:02 -0700
Subject: [PATCH v5 0/1] acpi: apei: Bug fix to enable APEI support for ARMv8
Message-ID: <1500586563-7088-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v5:
* Remove the patch set 1/2 as it was accepted
* Fix the signed-off-by using Co-authored-by

v4:
* Update patch commit log for gsi.c patch
* Make change to be 80 column aligned

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
Loc Ho (1):
  acpi: apei: Enable APEI multiple GHES source to share an single
    external IRQ

 drivers/acpi/apei/ghes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
1.8.3.1
