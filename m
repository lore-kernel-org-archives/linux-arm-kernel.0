From: jason.hui@linaro.org (Jason Liu)
Date: Thu, 3 Nov 2011 17:31:26 +0800
Subject: [PATCH v2 1/2] ARM:i.MX: fix build error in tzic/avic.c
In-Reply-To: <1320312687-20987-1-git-send-email-jason.hui@linaro.org>
References: <1320312687-20987-1-git-send-email-jason.hui@linaro.org>
Message-ID: <1320312687-20987-2-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/plat-mxc/tzic.c:105: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'tzic_handle_irq'

Signed-off-by: Jason Liu <jason.hui@linaro.org>
---
 arch/arm/plat-mxc/avic.c |    1 +
 arch/arm/plat-mxc/tzic.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
index 8875fb4..55f1569 100644
--- a/arch/arm/plat-mxc/avic.c
+++ b/arch/arm/plat-mxc/avic.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 #include <mach/common.h>
 #include <asm/mach/irq.h>
+#include <asm/exception.h>
 #include <mach/hardware.h>
 
 #include "irq-common.h"
diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
index e993a18..a3c164c 100644
--- a/arch/arm/plat-mxc/tzic.c
+++ b/arch/arm/plat-mxc/tzic.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 
 #include <asm/mach/irq.h>
+#include <asm/exception.h>
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-- 
1.7.4.1
