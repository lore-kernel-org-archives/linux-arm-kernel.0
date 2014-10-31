From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Sat, 1 Nov 2014 00:42:11 +0100
Subject: [PATCH v2 1/1] ARM: exynos_defconfig: Enable options for display
 panel support
In-Reply-To: <1408956336-17376-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1408956336-17376-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CABxcv=m-aNVcUU2C8LosCECxq1yZo2C3zfA2xe6z7jF8tFPsnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

On Mon, Aug 25, 2014 at 10:45 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Many Exynos devices have a display panel. Most of them just have
> a simple panel while others have more complex configurations that
> requires an embedded DisplayPort (eDP) to LVDS bridges.
>
> This patch enables the following features to be built in the kernel
> image to suport both setups:
>
> - Direct Rendering Manager (DRM)
> - DRM bridge registration and lookup framework
> - Parade ps8622/ps8625 eDP/LVDS bridge
> - NXP ptn3460 eDP/LVDS bridge
> - Exynos Fully Interactive Mobile Display controller (FIMD)
> - Panel registration and lookup framework
> - Simple panels
> - Backlight & LCD device support
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Tested-by: Kevin Hilman <khilman@linaro.org>
> ---

This patch is needed to have display working on many Exynos boards.

$subject enables the config option for the ps8622/ps8625 eDP/LVDS
bridge driver but this has not landed in mainline yet. Ajay will
re-spin a new revision of his series that adds this driver though,
after addressing some issues pointed out on a previous version.

The Kconfig symbol name (DRM_PS8622) won't change though so maybe is
not crazy to pick the patch as is since CONFIG_DRM_PS8622 will have to
be enabled later when the bridge driver lands. Or do you want me to
re-spin $subject removing that option?

Best regards,
Javier
