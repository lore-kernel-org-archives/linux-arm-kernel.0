From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 21 Jan 2010 22:56:58 +0100
Subject: [PATCH] hmt: adjust for new pwm_backlight->notify prototype
Message-ID: <1264111018-20920-1-git-send-email-jacmet@sunsite.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit cfc38999f (backlight: Pass device through notify callback)
added a struct device argument to the notify callback, but didn't
update the user of it in mach-hmt.c

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/arm/mach-s3c6410/mach-hmt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c6410/mach-hmt.c b/arch/arm/mach-s3c6410/mach-hmt.c
index cdd4b53..7619456 100644
--- a/arch/arm/mach-s3c6410/mach-hmt.c
+++ b/arch/arm/mach-s3c6410/mach-hmt.c
@@ -82,7 +82,7 @@ static int hmt_bl_init(struct device *dev)
 	return ret;
 }
 
-static int hmt_bl_notify(int brightness)
+static int hmt_bl_notify(struct device *dev, int brightness)
 {
 	/*
 	 * translate from CIELUV/CIELAB L*->brightness, E.G. from
-- 
1.6.5
