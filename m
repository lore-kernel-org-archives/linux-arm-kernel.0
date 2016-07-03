From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 3 Jul 2016 13:30:40 -0400
Subject: [PATCH 4/4] bus: simple-pm-bus: convert bool SIMPLE_PM_BUS to tristate
In-Reply-To: <20160703173040.23612-1-paul.gortmaker@windriver.com>
References: <20160703173040.23612-1-paul.gortmaker@windriver.com>
Message-ID: <20160703173040.23612-5-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig currently controlling compilation of this code is:

config SIMPLE_PM_BUS
        bool "Simple Power-Managed Bus Driver"

...meaning that it currently is not being built as a module by anyone.

In removing the orphaned modular support in a previous patch set,
Geert indicated he'd rather see this code converted to tristate.

I normally don't do that because it extends functionality that I
can't easily run time test or even know if the use case makes sense,
but since in this case the author has nominated it as such, we do
the conversion here.

Note that doesn't change the lack of run time testing ; this change
is only tested for sucessful compile and modpost.

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 3b205e212337..f4162c76a5f6 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -109,7 +109,7 @@ config OMAP_OCP2SCP
 	  OCP2SCP.
 
 config SIMPLE_PM_BUS
-	bool "Simple Power-Managed Bus Driver"
+	tristate "Simple Power-Managed Bus Driver"
 	depends on OF && PM
 	depends on ARCH_RENESAS || COMPILE_TEST
 	help
-- 
2.8.4
