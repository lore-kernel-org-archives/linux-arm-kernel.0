From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 8 Jun 2010 10:41:10 -0500
Subject: [PATCH] ep93xx: register backlight driver
In-Reply-To: <0D753D10438DA54287A00B0270842697636EE74BB1@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B0270842697636EE74BB1@AUSP01VMBX24.collaborationhost.net>
Message-ID: <0D753D10438DA54287A00B027084269763708AFE70@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, May 10, 2010 6:58 PM, H Hartley Sweeten wrote:
>
> Add the platform registration for the ep93xx backlight driver
> that is now queued in the backlight tree.
>
> Since the pwm BRIGHT signal only functions if the video system
> is operating, register the backlight when the framebuffer device
> is registered.
>
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>

Ryan,

The EP93xx backlight driver is now merged.
commit 08b3924b24cdb1942393dc3009335a2153bd2eac

Do you have any issues with this patch to enable it?

Regards,
Hartley

---

This is based off next-20100510, if needed I can rebase it off
another tree.

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 8d3f77e..07d7bb9 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -568,6 +568,11 @@ static struct platform_device ep93xx_fb_device = {
 	.resource		= ep93xx_fb_resource,
 };
 
+static struct platform_device ep93xx_bl_device = {
+	.name		= "ep93xx-bl",
+	.id		= -1,
+};
+
 /**
  * ep93xx_register_fb - Register the framebuffer platform device.
  * @data:	platform specific framebuffer configuration (__initdata)
@@ -576,6 +581,7 @@ void __init ep93xx_register_fb(struct ep93xxfb_mach_info *data)
 {
 	ep93xxfb_data = *data;
 	platform_device_register(&ep93xx_fb_device);
+	platform_device_register(&ep93xx_bl_device);
 }
 
 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
