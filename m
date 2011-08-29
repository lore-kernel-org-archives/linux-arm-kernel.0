From: khilman@ti.com (Kevin Hilman)
Date: Mon, 29 Aug 2011 10:35:39 -0700
Subject: [PATCH 06/22] OMAP3: voltagedomain data: add wakeup domain
In-Reply-To: <1314639355-12713-1-git-send-email-khilman@ti.com>
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
Message-ID: <1314639355-12713-7-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add wakeup voltage domain so that the wakeup powerdomain can have an
associated powerdomain.  Note that the scalable flat is not set for
the this voltagedomain, so it will not be fully initialized like
scalable voltage domains.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index 2167ef4..42d0b11 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -69,9 +69,14 @@ static struct voltagedomain omap3_voltdm_core = {
 	.vdd = &omap3_vdd2_info,
 };
 
+static struct voltagedomain omap3_voltdm_wkup = {
+	.name = "wakeup",
+};
+
 static struct voltagedomain *voltagedomains_omap3[] __initdata = {
 	&omap3_voltdm_mpu,
 	&omap3_voltdm_core,
+	&omap3_voltdm_wkup,
 	NULL,
 };
 
-- 
1.7.6
