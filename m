From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 30 Nov 2017 21:52:51 -0500
Subject: [PATCH V4 0/5] dmaengine: qcom_hidma: add support for bugfixed HW
Message-ID: <1512096776-22883-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce new ACPI and OF device ids for thw HW along with the helper
functions.

Changes from v3:
* introduce device_get_match_data() to read driver data
* remove ACPI/OF specific calls from qcom_hidma and replace it with the
new API.

Sinan Kaya (5):
  Documentation: DT: qcom_hidma: Bump HW revision for the bugfixed HW
  ACPI / bus: Introduce acpi_get_match_data() function
  device property: Introduce a common API to fetch device match data
  dmaengine: qcom_hidma: Add support for the new revision
  dmaengine: qcom_hidma: Add identity register support

 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  4 +--
 drivers/acpi/bus.c                                 | 12 +++++++
 drivers/base/property.c                            | 14 ++++++++
 drivers/dma/qcom/hidma.c                           | 41 ++++++++++------------
 include/linux/acpi.h                               |  6 ++++
 include/linux/property.h                           |  2 ++
 6 files changed, 55 insertions(+), 24 deletions(-)

-- 
1.9.1
