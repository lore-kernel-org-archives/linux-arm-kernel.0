From: ciminaghi@gnudd.com (Davide Ciminaghi)
Date: Fri, 23 Nov 2012 16:08:24 +0100
Subject: [PATCH 2/8] gpio: pl061 depends on ARM
In-Reply-To: <1353683310-23654-1-git-send-email-ciminaghi@gnudd.com>
References: <1353683310-23654-1-git-send-email-ciminaghi@gnudd.com>
Message-ID: <1353683310-23654-3-git-send-email-ciminaghi@gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alessandro Rubini <rubini@gnudd.com>

Commit dece904d (gpio: pl061: use chained_irq_* functions in irq
handler) introduced chained_irq_enter/exit, which is only
available for arch/arm and the driver won't compile elsewhere.

The dependency is thus made explicit, because AMBA is used in the x86
world by a PCI-to-AMBA bridge, to be submitted.

Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
---
 drivers/gpio/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 536bc23..fb238d3 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -185,7 +185,7 @@ config GPIO_MXS
 
 config GPIO_PL061
 	bool "PrimeCell PL061 GPIO support"
-	depends on ARM_AMBA
+	depends on ARM && ARM_AMBA
 	select GENERIC_IRQ_CHIP
 	help
 	  Say yes here to support the PrimeCell PL061 GPIO device
-- 
1.7.10.4
