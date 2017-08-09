From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 9 Aug 2017 18:53:33 +0800
Subject: [RFC PATCH 0/4] SMMUv3 MSI support
Message-ID: <1502276017-63108-1-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

IORT revision C introduced SMMUv3 MSI support for control interrupts,
which introduced a device ID mapping index to retrieve the dev ID
and ITS parent.

This patch set reuse the existing APIs to retrieve the data to
configure the MSI, but doing special checks to not introduce regressions
for CPI/NC--->SMMU--->ITS cases, please refer to each patch for detail
commit message.

Hanjun Guo (4):
  ACPICA: Add SMMUv3 device ID mapping index support
  ACPI: IORT: lookup iort node via fwnode
  ACPI: IORT: Skip SMMUv3 device ID map for two steps mappings
  ACPI: IORT: Add SMMUv3 MSI support

 drivers/acpi/arm64/iort.c | 126 +++++++++++++++++++++++++++++++++++++++++-----
 include/acpi/actbl2.h     |   1 +
 2 files changed, 115 insertions(+), 12 deletions(-)

-- 
1.7.12.4
