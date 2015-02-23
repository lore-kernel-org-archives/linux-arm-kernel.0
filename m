From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 23 Feb 2015 11:32:14 +0100
Subject: [PATCHv3 0/2] drm: atmel-hlcdc: PM support
In-Reply-To: <1424627464-16869-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1424627464-16869-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <20150223113214.584ee794@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

On Sun, 22 Feb 2015 18:51:02 +0100
Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:

> This series adds basic PM support for Atmel HLCDC.
> 
> This series depends on:
> 
> [PATCH] drm: atmel-hlcdc: remove useless pm_runtime_put_sync in probe
>   <1423841785-23105-1-git-send-email-boris.brezillon@free-electrons.com>
> [PATCH v3] drm: atmel-hlcdc: Atomic mode-setting conversion
>   <1423842415-23412-1-git-send-email-boris.brezillon@free-electrons.com>

Thanks, I'll queue the series to my drm-atmel-hlcdc-devel branch (with
Andrzej's Reviewed-by).

> 
> Changes since v2:
>   * Save previous state of crtc's so we don't enable them unconditionally
>     at resume.
>   * Remove obsolete use of drm_driver.suspend and drm_driver.resume
>     callbacks
>   * Merged atmel_hlcdc_dc_suspend to atmel_hlcdc_dc_drm_suspend and
>     atmel_hlcdc_dc_resume to atmel_hlcdc_dc_drm_resume since we don't
>     need the previous callbacks anymore
>   * Removed useless check of drm_dev in suspend/resume functions
> 
> Changes since v1:
>   * (*crtc_funcs->disable)(crtc) replaced to crtc_funcs->disable(crtc)
> 
> Sylvain Rochet (2):
>   drm: atmel-hlcdc: Add PM suspend/resume support
>   drm: atmel-hlcdc: Add pinctrl PM select sleep,default state in CRTC
>     suspend/resume
> 
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c |  3 ++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c   | 47 ++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
