From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri,  1 Dec 2017 23:27:37 -0500
Subject: [PATCH V5 0/7] dmaengine: qcom_hidma: add support for bugfixed HW
Message-ID: <1512188864-773-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce new ACPI and OF device ids for thw HW along with the helper
functions.

Changes from v4:
* rework the device_get_match_data() to use fwnode callbacks
* change calling parameter of acpi_get_match_data() to struct acpi_device()

Sinan Kaya (7):
  Documentation: DT: qcom_hidma: Bump HW revision for the bugfixed HW
  ACPI / bus: Introduce acpi_get_match_data() function
  device property: Introduce a common API to fetch device match data
  OF: properties: Implement get_match_data() callback
  ACPI: properties: Implement get_match_data() callback
  dmaengine: qcom_hidma: Add support for the new revision
  dmaengine: qcom_hidma: Add identity register support

 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  4 +--
 drivers/acpi/bus.c                                 | 13 +++++++
 drivers/acpi/property.c                            | 12 +++++++
 drivers/base/property.c                            |  7 ++++
 drivers/dma/qcom/hidma.c                           | 41 ++++++++++------------
 drivers/of/property.c                              | 17 +++++++++
 include/linux/acpi.h                               |  8 +++++
 include/linux/fwnode.h                             |  4 +++
 include/linux/property.h                           |  2 ++
 9 files changed, 84 insertions(+), 24 deletions(-)

-- 
1.9.1
