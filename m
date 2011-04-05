From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Tue,  5 Apr 2011 17:38:09 -0400
Subject: [PATCH 6/6] da8xx: enable the use of the ICPFUNC in i2c-davinci
In-Reply-To: <cover.1302031487.git.bengardiner@nanometrics.ca>
References: <cover.1302031487.git.bengardiner@nanometrics.ca>
Message-ID: <f1ff3f2888725a1e03541e0be5c0880f0591aea2.1302031487.git.bengardiner@nanometrics.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both the da850 and da830 have an I2C controller which has the ICPFUNC
registers. Indicate this for all da830 and da850 boards by setting the
has_pfunc flag true in the da8xx utility setup routine for registering the
I2C controller

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Ben Dooks <ben-linux@fluff.org>

---
 arch/arm/mach-davinci/devices-da8xx.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index beda8a4..da01558 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -324,6 +324,12 @@ int __init da8xx_register_i2c(int instance,
 	else
 		return -EINVAL;
 
+	/*
+	 * Both the DA850 and DA830 have an I2C controller which has the
+	 * ICPFUNC et. al. registers
+	 */
+	pdata->has_pfunc = 1;
+
 	pdev->dev.platform_data = pdata;
 	return platform_device_register(pdev);
 }
-- 
1.7.1
