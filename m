From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Wed, 19 Jun 2013 14:45:39 +0530
Subject: [PATCH v3 2/5] ARM: davinci: da850: override device name of UART in
 DT kernel
In-Reply-To: <1371633342-1210-1-git-send-email-prakash.pm@ti.com>
References: <1371633342-1210-1-git-send-email-prakash.pm@ti.com>
Message-ID: <1371633342-1210-3-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Populate OF_DEV_AUXDATA with desired device name so as to prevent
clk_get failures.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 arch/arm/mach-davinci/da8xx-dt.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 961aea8..e429945 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -47,6 +47,9 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f07000, "ecap", NULL),
 	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f08000, "ecap", NULL),
 	OF_DEV_AUXDATA("ti,da830-spi", 0x01f0e000, "spi_davinci.1", NULL),
+	OF_DEV_AUXDATA("ns16550a", 0x01c42000, "serial8250.0", NULL),
+	OF_DEV_AUXDATA("ns16550a", 0x01d0c000, "serial8250.1", NULL),
+	OF_DEV_AUXDATA("ns16550a", 0x01d0d000, "serial8250.2", NULL),
 	{}
 };
 
-- 
1.7.4.1
