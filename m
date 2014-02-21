From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 21 Feb 2014 16:50:01 +0100
Subject: [PATCHv7][ 4/7] staging: imx-drm: Use de-active and
 pixelclk-active display-timings.
In-Reply-To: <1392991205-25371-4-git-send-email-denis@eukrea.com>
References: <1392991205-25371-1-git-send-email-denis@eukrea.com>
 <1392991205-25371-4-git-send-email-denis@eukrea.com>
Message-ID: <20140221165001.2e7c7e08@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Denis Carikli wrote:
> If de-active and/or pixelclk-active properties were set in the
> display-timings DT node, they were not used.
> 
> Instead the data-enable and the pixel data clock polarity
> were hardcoded.
> 
> This change is needed for making the eukrea-cpuimx51
>   QVGA display work.
> 
> Cc: Eric B?nard <eric@eukrea.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: devel at driverdev.osuosl.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> ChangeLog v6->v7:
> - Shrinked even more the Cc list.
> - Rebased the patch
> - val is now initialized in imx_pd_connector_get_modes
> 
> ChangeLog v5->v6:
> - Remove people not concerned by this patch from the Cc list.
> - Removed wrong coments from the code.
> - Corrected the code style of the "if (!!val)"
> 
> ChangeLog v3->v4:
> - The old patch was named "staging: imx-drm: ipuv3-crtc: don't harcode some mode".
> - Reworked the patch entierly: we now takes the mode flags from the device tree.
> 
> ChangeLog v2->v3:
> - Added some interested people in the Cc list.
> - Ajusted the flags to match the changes in "drm: Add the lacking
>   DRM_MODE_FLAG_* for matching the DISPLAY_FLAGS_*"
> ---
>  drivers/staging/imx-drm/imx-drm.h          |    3 +++
>  drivers/staging/imx-drm/ipuv3-crtc.c       |    8 ++++++--
>  drivers/staging/imx-drm/parallel-display.c |   27 +++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
> index ae90c9c..dfdc180 100644
> --- a/drivers/staging/imx-drm/imx-drm.h
> +++ b/drivers/staging/imx-drm/imx-drm.h
> @@ -5,6 +5,9 @@
>  
>  #define IPU_PIX_FMT_GBR24	v4l2_fourcc('G', 'B', 'R', '3')
>  
> +#define IMXDRM_MODE_FLAG_DE_HIGH		(1<<0)
> +#define IMXDRM_MODE_FLAG_PIXDATA_POSEDGE	(1<<1)
> +
CodingStyle: spaces around operators...?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
