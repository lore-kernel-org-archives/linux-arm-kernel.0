From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 11 Sep 2015 14:01:54 +0900
Subject: [PATCH] ARM: exynos_defconfig: Disable simplefb support
In-Reply-To: <1441892552-13819-1-git-send-email-javier@osg.samsung.com>
References: <1441892552-13819-1-git-send-email-javier@osg.samsung.com>
Message-ID: <55F26042.2080600@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.09.2015 22:42, Javier Martinez Canillas wrote:
> The simplefb driver allows the kernel to render on a pre-allocated
> buffer that's been initialized by firmware before the kernel boots.
> 
> This option was enabled to have display working on the Exynos5250
> Snow Chromebook by commit da9d0fbf5e9a ("ARM: exynos: defconfig
> update") since proper DRM/KMS support did not exist at that time.
> 
> But now that the Exynos DRM driver has support for this hardware,
> there is no need to have simplefb enabled. In fact, if a user has
> a u-boot that injects the simplefb dev node to the FDT before pass
> it to the kernel, display won't be properly initialized and only a
> blank screen will be shown since there isn't a proper handoff from
> the simplefb driver to the Exynos DRM driver.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  arch/arm/configs/exynos_defconfig | 1 -
>  1 file changed, 1 deletion(-)

Seems logical. None of the boards use simple-framebuffer compatible
anyway. I understand that on Snow simplefb was needed along with change
in Uboot like this one:
https://chromium.googlesource.com/chromiumos/third_party/u-boot/+/refs/changes/58/49358/2

and now none of Exynos boards use simplefb anymore?

Best regards,
Krzysztof
