From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 15 Oct 2010 23:44:59 +0800
Subject: [PATCH] arm/nuc900: disable hardware cursor setting
Message-ID: <4CB876FB.3020508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Currently, the nuc900 lcd driver did not implement controlling
hardware cursor function, so enabling it which results in penal upper left 64x64 
part has been shown in black, so I disable it.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
---
  arch/arm/mach-w90x900/dev.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
index 5b0c38a..e1d262c 100644
--- a/arch/arm/mach-w90x900/dev.c
+++ b/arch/arm/mach-w90x900/dev.c
@@ -438,7 +438,7 @@ static struct nuc900fb_display nuc900_lcd_info[] = {
  		.upper_margin	= 18,
  		.lower_margin	= 4,
  		.vsync_len	= 1,
-		.dccs		= 0x8e00041a,
+		.dccs		= 0x0e00041a,
  		.devctl		= 0x060800c0,
  		.fbctrl		= 0x00a000a0,
  		.scale		= 0x04000400,
-- 
1.6.3.3
