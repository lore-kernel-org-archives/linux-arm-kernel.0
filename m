From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 21 Sep 2017 21:17:14 +0800
Subject: [RFC PATCH v2 0/4] IORT SMMUv3 MSI support
Message-ID: <1505999838-52530-1-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

IORT revision C introduced SMMUv3 MSI support for control interrupts,
which introduced a device ID mapping index to retrieve the dev ID
and ITS parent, adding its support in this patch set, please refer
to each patch for detail commit message.

RFC v1 -> RFC v2:
 - Introduce a new API iort_set_device_domain() to find the MSI domain
   for an SMMUv3 (or any other IORT table node) to reduce the complex
   of doing that via acpi_configure_pmsi_domain().

Hanjun Guo (3):
  ACPICA: Add SMMUv3 device ID mapping index support
  ACPI: IORT: lookup iort node via fwnode
  ACPI: IORT: Skip SMMUv3 device ID map for two steps mappings

Lorenzo Pieralisi (1):
  ACPI: IORT: SMMUv3 nodes MSI support

 drivers/acpi/arm64/iort.c | 157 ++++++++++++++++++++++++++++++++++++++++++++--
 include/acpi/actbl2.h     |   1 +
 2 files changed, 152 insertions(+), 6 deletions(-)

-- 
1.7.12.4
