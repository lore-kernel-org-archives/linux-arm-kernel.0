From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 19 Feb 2014 07:58:46 +0100
Subject: [PATCH 1/1] imx-drm: imx-drm-core: fix the build warning
In-Reply-To: <1392787693-12539-1-git-send-email-peter.chen@freescale.com>
References: <1392787693-12539-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20140219075846.32f5fde4@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Peter Chen wrote:
> /home/b29397/work/projects/upstream/usb/usb/drivers/staging/imx-drm/imx-drm-core.c: In function 'imx_drm_driver_unload':
> /home/b29397/work/projects/upstream/usb/usb/drivers/staging/imx-drm/imx-drm-core.c:87:25: warning: unused variable 'imxdrm' [-Wunused-variable]
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/staging/imx-drm/imx-drm-core.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
> index 236ed66..573fe88 100644
> --- a/drivers/staging/imx-drm/imx-drm-core.c
> +++ b/drivers/staging/imx-drm/imx-drm-core.c
> @@ -84,8 +84,6 @@ static void imx_drm_driver_lastclose(struct drm_device *drm)
>  
>  static int imx_drm_driver_unload(struct drm_device *drm)
>  {
> -	struct imx_drm_device *imxdrm = drm->dev_private;
> -
>  	imx_drm_device_put();
>  
>  	drm_vblank_cleanup(drm);
>
You obviously missed: <20140210102906.GP26684@n2100.arm.linux.org.uk>


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
