From: Jiri.Pinkava@vscht.cz (Pinkava J.)
Date: Thu, 6 May 2010 00:12:14 +0200
Subject: [PATCH 2/9] fix: suspended wrong USB port on Acer n35
In-Reply-To: <4BE1EBFE.9080601@vscht.cz>
References: <4BE1EBFE.9080601@vscht.cz>
Message-ID: <4BE1ED3E.1050201@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is bug in USB setup code for Acer n35 (it is related directly to s3c2410,
see doc). We want suspend host port (is not connected) but device port should be
active.

Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
 arch/arm/mach-s3c2410/mach-n30.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index 684710f..1b635fd 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -532,7 +532,7 @@ static void __init n30_init(void)
 		s3c2410_modify_misccr(S3C2410_MISCCR_USBHOST |
 				      S3C2410_MISCCR_USBSUSPND0 |
 				      S3C2410_MISCCR_USBSUSPND1,
-				      S3C2410_MISCCR_USBSUSPND1);
+				      S3C2410_MISCCR_USBSUSPND0);

 		platform_add_devices(n35_devices, ARRAY_SIZE(n35_devices));
 	}
-- 
1.7.1
