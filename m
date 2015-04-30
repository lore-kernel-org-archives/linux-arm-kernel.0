From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 30 Apr 2015 02:37:59 +0200
Subject: [PATCH 1/1] Revert "ARM: dts: add display power domain for
 exynos5250"
In-Reply-To: <1430336716.19504.92.camel@collabora.co.uk>
References: <1427107800-21668-1-git-send-email-javier.martinez@collabora.co.uk>	
 <7hr3r2suiw.fsf@deeprootsystems.com>
 <1430336716.19504.92.camel@collabora.co.uk>
Message-ID: <55417967.80304@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 04/29/2015 09:45 PM, Sjoerd Simons wrote:
> On Wed, 2015-04-29 at 10:40 -0700, Kevin Hilman wrote:
>> Javier Martinez Canillas <javier.martinez@collabora.co.uk> writes:
> 
>> Tested-by: Kevin Hilman <khilman@linaro.org>
>> 
>> FWIW, this patch fixes the boot panics when using MMC rootfs on
>> exynos5800-peach-pi with current linux-next that have been happening
>> for awhile.
> 
> That seems unlikely as this patch changes things in the exynos5250.dtsi,
> which isn't used by exynos5800-peach-pi.?
>

Indeed, it will be surprising if $subject changes any behavior on
Exynos5420/5422/5800 machines.

FWIW, this patch is not needed anymore since the right fix is Krzysztof's
"drm/exynos: Enable DP clock to fix display on Exynos5250 and other" patch
which is already in linux-next.

The regression on Exynos5420/5422/5800 that has been for a while is fixed
by "ARM: dts: Make DP a consumer of DISP1 power domain on Exynos5420" [0]
which has been posted many weeks ago.
 
>> For several months now, DRM/display related stuff is very routinely
>> breaking basic booting on exynos5, which gives the rather strong
>> impression that the DRM stuff is not tested well enough to be merged.
> 
> Unfortunately it seems to have been that way for ages, but only has
> started being visible since Javier turned on the various exynos DRM
> drivers on in exynos_defconfig.. So now we're actually seeing bugs
> rather then just having broken code sit around :/
>

Agreed.

Best regards,
Javier

[0]: https://lkml.org/lkml/2015/4/12/153
