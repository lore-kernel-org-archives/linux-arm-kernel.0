From: robh@kernel.org (Rob Herring)
Date: Tue, 15 Sep 2015 13:25:37 -0500
Subject: [PATCH RFC 6/8] drm: hisilicon: Add support for fbdev
In-Reply-To: <1442309834-21420-7-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <1442309834-21420-7-git-send-email-kong.kongxinwei@hisilicon.com>
Message-ID: <55F862A1.30308@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2015 04:37 AM, Xinwei Kong wrote:
> If you config DRM_HISI_FBDEV optional, this patch will only support fbdev
> mode while also supporting double buffer.

This is a lot of duplicated code from CMA fbdev. Is double buffering the
only reason why CMA fbdev can't be used or are there some other
constraints? Double buffering in fbdev has always been a hack, so I'm
guessing that is not a feature that should be added here.

Rob

> Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> Signed-off-by: Jiwen Qi <qijiwen@hisilicon.com>
> Signed-off-by: Yu Gong <gongyu@hisilicon.com>
> ---
>  drivers/gpu/drm/hisilicon/Kconfig              |  13 +
>  drivers/gpu/drm/hisilicon/Makefile             |   3 +-
>  drivers/gpu/drm/hisilicon/hisi_drm_connector.c |   4 +
>  drivers/gpu/drm/hisilicon/hisi_drm_drv.c       |   9 +
>  drivers/gpu/drm/hisilicon/hisi_drm_dsi.c       |  15 +
>  drivers/gpu/drm/hisilicon/hisi_drm_fb.h        |   5 +
>  drivers/gpu/drm/hisilicon/hisi_drm_fbdev.c     | 395 +++++++++++++++++++++++++
>  drivers/gpu/drm/hisilicon/hisi_drm_fbdev.h     |  24 ++
>  8 files changed, 467 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_fbdev.c
>  create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_fbdev.h
