From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 30 Nov 2017 12:57:00 +0100
Subject: [PATCH] bus: simple-pm-bus: convert bool SIMPLE_PM_BUS to tristate
Message-ID: <1512043020-23452-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

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

[geert: Ethernet is probed successfully on sh73a0/kzm9g after
        insmodding simple-pm-bus.ko]

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index dc7b3c7b7d42fd09..57e011d36a79fce3 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -120,7 +120,7 @@ config QCOM_EBI2
 	  SRAM, ethernet adapters, FPGAs and LCD displays.
 
 config SIMPLE_PM_BUS
-	bool "Simple Power-Managed Bus Driver"
+	tristate "Simple Power-Managed Bus Driver"
 	depends on OF && PM
 	help
 	  Driver for transparent busses that don't need a real driver, but
-- 
2.7.4
