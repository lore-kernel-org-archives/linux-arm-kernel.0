From: david@lechnology.com (David Lechner)
Date: Sat, 16 Apr 2016 12:00:18 -0500
Subject: [PATCH v2 2/4] ARM: davinci: Add spi0 lookup to da8xx-dt for clock
 matching
In-Reply-To: <1460826020-1256-1-git-send-email-david@lechnology.com>
References: <1460826020-1256-1-git-send-email-david@lechnology.com>
Message-ID: <1460826020-1256-3-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed to match the device-tree node for spi0 to the
non-device-tree clock.

Signed-off-by: David Lechner <david@lechnology.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---

code portion of previous "ARM: davinci: add spi0 to da850 device tree" patch.

no change.

 arch/arm/mach-davinci/da8xx-dt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 64f3887..754f478 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -28,6 +28,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f06000, "ecap", NULL),
 	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f07000, "ecap", NULL),
 	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f08000, "ecap", NULL),
+	OF_DEV_AUXDATA("ti,da830-spi", 0x01c41000, "spi_davinci.0", NULL),
 	OF_DEV_AUXDATA("ti,da830-spi", 0x01f0e000, "spi_davinci.1", NULL),
 	OF_DEV_AUXDATA("ns16550a", 0x01c42000, "serial8250.0", NULL),
 	OF_DEV_AUXDATA("ns16550a", 0x01d0c000, "serial8250.1", NULL),
-- 
1.9.1
