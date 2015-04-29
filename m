From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Wed, 29 Apr 2015 21:45:16 +0200
Subject: [PATCH 1/1] Revert "ARM: dts: add display power domain for
 exynos5250"
In-Reply-To: <7hr3r2suiw.fsf@deeprootsystems.com>
References: <1427107800-21668-1-git-send-email-javier.martinez@collabora.co.uk>
 <7hr3r2suiw.fsf@deeprootsystems.com>
Message-ID: <1430336716.19504.92.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-04-29 at 10:40 -0700, Kevin Hilman wrote:
> Javier Martinez Canillas <javier.martinez@collabora.co.uk> writes:

> Tested-by: Kevin Hilman <khilman@linaro.org>
> 
> FWIW, this patch fixes the boot panics when using MMC rootfs on
> exynos5800-peach-pi with current linux-next that have been happening
> for awhile.

That seems unlikely as this patch changes things in the exynos5250.dtsi,
which isn't used by exynos5800-peach-pi.?

> For several months now, DRM/display related stuff is very routinely
> breaking basic booting on exynos5, which gives the rather strong
> impression that the DRM stuff is not tested well enough to be merged.

Unfortunately it seems to have been that way for ages, but only has
started being visible since Javier turned on the various exynos DRM
drivers on in exynos_defconfig.. So now we're actually seeing bugs
rather then just having broken code sit around :/

-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
