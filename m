From: s-anna@ti.com (Suman Anna)
Date: Mon, 18 Sep 2017 19:28:33 -0500
Subject: [PATCH 3/3] ARM: davinci: da8xx-dt: Add OF_DEV_AUXDATA entry for DSP
 clock matching
In-Reply-To: <20170919002833.5677-1-s-anna@ti.com>
References: <20170919002833.5677-1-s-anna@ti.com>
Message-ID: <20170919002833.5677-4-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the OF_DEV_AUXDATA entry needed to match the device-tree DSP node
to its non-device-tree clock, so that the da8xx-remoteproc driver can
properly enable the clocks. The device name has also been assigned
"davinci-rproc.0" to match the device id used in the da850_clks
clk_lookup array.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-davinci/da8xx-dt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 5699ce39e64f..f06db6700ab2 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -54,6 +54,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,da830-usb-phy", 0x01c1417c, "da8xx-usb-phy", NULL),
 	OF_DEV_AUXDATA("ti,da850-ahci", 0x01e18000, "ahci_da850", NULL),
 	OF_DEV_AUXDATA("ti,da850-vpif", 0x01e17000, "vpif", NULL),
+	OF_DEV_AUXDATA("ti,da850-dsp", 0x11800000, "davinci-rproc.0", NULL),
 	{}
 };
 
-- 
2.13.1
