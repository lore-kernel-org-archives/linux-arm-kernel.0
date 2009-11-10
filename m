From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 10 Nov 2009 23:21:55 +0000
Subject: [PATCH 3/4] AT2440EVB: Remove duplicated s3c_device_sdi.name set
In-Reply-To: <1257895316-9156-3-git-send-email-ben-linux@fluff.org>
References: <1257895316-9156-1-git-send-email-ben-linux@fluff.org>
	<1257895316-9156-2-git-send-email-ben-linux@fluff.org>
	<1257895316-9156-3-git-send-email-ben-linux@fluff.org>
Message-ID: <1257895316-9156-4-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AT2440EVB should not be changing the s3c_device_sdi.name as this is
part of the initialisation process done by the CPU detection process
and actually present in arch/arm/plat-s3c24xx/s3c24xx.c.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2440/mach-at2440evb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-at2440evb.c b/arch/arm/mach-s3c2440/mach-at2440evb.c
index d73ef9a..aa69290 100644
--- a/arch/arm/mach-s3c2440/mach-at2440evb.c
+++ b/arch/arm/mach-s3c2440/mach-at2440evb.c
@@ -216,7 +216,6 @@ static struct platform_device *at2440evb_devices[] __initdata = {
 
 static void __init at2440evb_map_io(void)
 {
-	s3c_device_sdi.name = "s3c2440-sdi";
 	s3c_device_sdi.dev.platform_data = &at2440evb_mci_pdata;
 
 	s3c24xx_init_io(at2440evb_iodesc, ARRAY_SIZE(at2440evb_iodesc));
-- 
1.6.5
