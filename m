From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 9 Feb 2011 14:35:26 +0100
Subject: [PATCH 1/2] video: Add i.MX23/28 framebuffer driver
In-Reply-To: <1297257651-8002-2-git-send-email-s.hauer@pengutronix.de>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<1297257651-8002-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <19794.38942.679388.812321@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Sascha Hauer writes:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: linux-fbdev at vger.kernel.org
> Cc: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-mxs/include/mach/fb.h |   48 ++
>  drivers/video/Kconfig               |    9 +
>  drivers/video/Makefile              |    1 +
>  drivers/video/mxsfb.c               |  914 +++++++++++++++++++++++++++++++++++
>  4 files changed, 972 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/include/mach/fb.h
>  create mode 100644 drivers/video/mxsfb.c
> 
[...]
> diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
> new file mode 100644
> index 0000000..92a5804
> --- /dev/null
> +++ b/drivers/video/mxsfb.c
[...]
> +static int __devexit mxsfb_remove(struct platform_device *pdev)
> +{
> +	struct fb_info *fb_info = platform_get_drvdata(pdev);
> +	struct mxsfb_info *host = to_imxfb_host(fb_info);
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	mxsfb_disable_controller(fb_info);
>
IMO this should also be guarded by an:
|	if (host->enabled)
otherwise it may lead to an unbalanced clk_disable() call.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
