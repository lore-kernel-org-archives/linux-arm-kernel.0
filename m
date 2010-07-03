From: patrick@georgi-clan.de (Patrick Georgi)
Date: Sat, 03 Jul 2010 11:58:48 +0200
Subject: [PATCH] ARM: S3C64XX: Framebuffer fix for SmartQ5
Message-ID: <4C2F09D8.1000007@georgi-clan.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[resend, due to a hint where to Cc: it]

the following change makes the framebuffer work on SmartQ5. There are
still some problems with ADC, so this patch alone won't make the device
run (or even give a working fb), but it's one issue less to think about.

Signed-off-by: Patrick Georgi <patrick@georgi-clan.de>

diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c
b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 1d0326e..27c2901 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -136,10 +136,10 @@ static struct s3c_fb_pd_win smartq5_fb_win0 = {
        .win_mode       = {
                .pixclock       = 1000000000000ULL /
                                ((40+1+216+800)*(10+1+35+480)*80),
-               .left_margin    = 40,
-               .right_margin   = 216,
-               .upper_margin   = 10,
-               .lower_margin   = 35,
+               .left_margin    = 216,
+               .right_margin   = 40,
+               .upper_margin   = 35,
+               .lower_margin   = 10,
                .hsync_len      = 1,
                .vsync_len      = 1,
                .xres           = 800,
