From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Nov 2015 21:26:31 +0100
Subject: [PATCH 2/2] [media] include/media: move platform driver headers
 to a separate dir
In-Reply-To: <09e182fa61a7122356b790cd2a4a7f622dabb4ce.1447261977.git.mchehab@osg.samsung.com>
References: <413d2bb0b813a7e62867de7a94b0ab61e16cb1cb.1447261977.git.mchehab@osg.samsung.com>
 <09e182fa61a7122356b790cd2a4a7f622dabb4ce.1447261977.git.mchehab@osg.samsung.com>
Message-ID: <4220808.QEkJDXYE1T@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 November 2015 15:14:48 Mauro Carvalho Chehab wrote:
>  rename include/media/{ => platform}/exynos-fimc.h (100%)
>  rename include/media/{ => platform}/mmp-camera.h (100%)
>  rename include/media/{ => platform}/omap1_camera.h (100%)
>  rename include/media/{ => platform}/omap4iss.h (100%)
>  rename include/media/{ => platform}/s3c_camif.h (100%)
>  rename include/media/{ => platform}/s5p_hdmi.h (100%)
>  rename include/media/{ => platform}/sh_mobile_ceu.h (100%)
>  rename include/media/{ => platform}/sh_mobile_csi2.h (100%)
>  rename include/media/{ => platform}/sh_vou.h (100%)
>  rename include/media/{ => platform}/sii9234.h (100%)
>  rename include/media/{ => platform}/soc_camera.h (100%)
>  rename include/media/{ => platform}/soc_camera_platform.h (98%)
>  rename include/media/{ => platform}/soc_mediabus.h (100%)

This still seems to be a mix of various things. Some of these are interfaces
between drivers, while others declare a foo_platform_data structure that
is used to interface between platform code and the driver.

I think the latter should go into include/linux/platform_data/media/*.h instead.

	Arnd
