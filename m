From: lho@apm.com (Loc Ho)
Date: Mon,  7 Dec 2015 17:16:14 -0700
Subject: [PATCH 2/2] i2c:dw: Add APM X-Gene ACPI I2C device support
In-Reply-To: <1449533774-22672-1-git-send-email-lho@apm.com>
References: <1449533774-22672-1-git-send-email-lho@apm.com>
Message-ID: <1449533774-22672-3-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable APM X-Gene ACPI I2C device support by adding the
corresponding ACPI ID. The platform ACPI APD corresponding
change is required to provide the proper clock frequency input.

Signed-off-by: Loc Ho <lho@apm.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 809579e..423371d 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -117,6 +117,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ "80860F41", 0 },
 	{ "808622C1", 0 },
 	{ "AMD0010", 0 },
+	{ "APMC0D0F", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
-- 
1.7.1
