From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 13 Dec 2017 02:20:46 -0500
Subject: [PATCH V8 0/7] dmaengine: qcom_hidma: add support for bugfixed HW
Message-ID: <1513149653-19451-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce new ACPI and OF device ids for thw HW along with the helper
functions.

Changes from v7:
* rebase to 4.15-rc1

Sinan Kaya (7):
  Documentation: DT: qcom_hidma: Bump HW revision for the bugfixed HW
  ACPI / bus: Introduce acpi_get_match_data() function
  device property: Introduce a common API to fetch device match data
  OF: properties: Implement get_match_data() callback
  ACPI: properties: Implement get_match_data() callback
  dmaengine: qcom_hidma: Add support for the new revision
  dmaengine: qcom_hidma: Add identity register support

 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  4 +--
 drivers/acpi/bus.c                                 | 18 ++++++++++
 drivers/acpi/property.c                            |  8 +++++
 drivers/base/property.c                            |  7 ++++
 drivers/dma/qcom/hidma.c                           | 41 ++++++++++------------
 drivers/of/property.c                              |  8 +++++
 include/linux/acpi.h                               |  6 ++++
 include/linux/fwnode.h                             |  4 +++
 include/linux/property.h                           |  2 ++
 9 files changed, 74 insertions(+), 24 deletions(-)

-- 
1.9.1
