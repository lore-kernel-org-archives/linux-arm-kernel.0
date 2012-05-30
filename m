From: rubini@gnudd.com (Alessandro Rubini)
Date: Wed, 30 May 2012 19:46:10 +0200
Subject: [PATCH RFC 3/3] i2c-nomadik: depend on ARM_AMBA, not PLAT_NOMADIK
In-Reply-To: <cover.1338398567.git.rubini@gnudd.com>
References: <cover.1338398567.git.rubini@gnudd.com>
Message-ID: <5be16088e4f9170da1540a3e4abe54175d5bcce2.1338398567.git.rubini@gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gateware device has been used outside of the Nomadik world, using
the pci-amba bridge driver, so loosen the dependencies.

Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
---
 drivers/i2c/busses/Kconfig |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 7244c8b..e9f9c5d 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -479,10 +479,11 @@ config I2C_MXS
 
 config I2C_NOMADIK
 	tristate "ST-Ericsson Nomadik/Ux500 I2C Controller"
-	depends on PLAT_NOMADIK
+	depends on ARM_AMBA
 	help
 	  If you say yes to this option, support will be included for the
-	  I2C interface from ST-Ericsson's Nomadik and Ux500 architectures.
+	  I2C interface from ST-Ericsson's Nomadik and Ux500 architectures,
+	  as well as the STA2X11 PCIe I/O HUB.
 
 config I2C_NUC900
 	tristate "NUC900 I2C Driver"
-- 
1.7.7.2
