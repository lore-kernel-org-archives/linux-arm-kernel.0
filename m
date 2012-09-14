From: dciminaghi@mail.gnudd.com (Davide Ciminaghi)
Date: Fri, 14 Sep 2012 18:23:57 +0200
Subject: [PATCH 2/8] gpio: pl061 depends on ARM
In-Reply-To: <1347639843-32119-1-git-send-email-dciminaghi@mail.gnudd.com>
References: <1347639843-32119-1-git-send-email-dciminaghi@mail.gnudd.com>
Message-ID: <1347639843-32119-3-git-send-email-dciminaghi@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alessandro Rubini <rubini@gnudd.com>

Patch dece904d itroduced chained_irq_enter/exit, which is only
available for arch/arm and the driver won't compile elsewhere.

The dependency is thus made explicit, because AMBA is used in the x86
world by a PCI-to-AMBA bridge, to be submitted.

Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
---
 drivers/gpio/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 95778f1..090abd6 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -164,7 +164,7 @@ config GPIO_MXS
 
 config GPIO_PL061
 	bool "PrimeCell PL061 GPIO support"
-	depends on ARM_AMBA
+	depends on ARM && ARM_AMBA
 	select GENERIC_IRQ_CHIP
 	help
 	  Say yes here to support the PrimeCell PL061 GPIO device
-- 
1.7.9.1
