From: dianders@chromium.org (Doug Anderson)
Date: Tue, 29 Sep 2015 10:28:15 -0700
Subject: [PATCH] ARM: dts: Add Exynos5250 Snow Rev5+ support
In-Reply-To: <1443527855-434-1-git-send-email-javier@osg.samsung.com>
References: <1443527855-434-1-git-send-email-javier@osg.samsung.com>
Message-ID: <CAD=FV=Vmdv6sTmbVyxE=04ycNCOzEWJpfMpzGnihOwaW0ZFzmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On Tue, Sep 29, 2015 at 4:57 AM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> There are 2 revisions of the Exynos5250 Snow Chromebook that were shipped:
> Rev4 and Rev5. The only difference between these 2 revisions is the codec,
> Rev4 has a max98095 codec while Rev5 has a max98090.
>
> Mainline only supports Rev4 so this patch moves the common device nodes to
> a DTSI file and adds a DTS for the Exynos5250 Snow Rev5.
>
> The Snow Rev5 DTS is based on the DTS found in the ChromiumOS 3.8 tree.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>
> ---
>
> The DTS in the vendor ChromeOS tree are called exynos5250-snow-rev{4,5}.dtb
> but I decided to leave Rev4 as exynos5250-snow.dtb to avoid breaking u-boot
> that has CONFIG_DEFAULT_DEVICE_TREE="exynos5250-snow" in snow_defconfig.
>
> Also, ChromiumOS Rev4 DTS has "google,snow-rev4" in its compatible string
> but was not added in mainline since Rev4 firmware fallbacks to "google,snow"
> and Rev5 searches for "google,snow-rev5". That way the compatible string
> could be consistent with the DTS naming and still be able to pack both Rev4
> and Rev5 FDT in the same FIT image and let the firmware pick the correct FDT.

Looking at all the notes in the DTS in the ChromeOS tree, this sounds
like it should be fine.


>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi | 684 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5250-snow-rev5.dts    |  47 ++
>  arch/arm/boot/dts/exynos5250-snow.dts         | 666 +------------------------
>  4 files changed, 733 insertions(+), 665 deletions(-)

Thanks!  Note:

$ pwclient git-am 7285451
Applying patch #7285451 using 'git am'
Description: ARM: dts: Add Exynos5250 Snow Rev5+ support
Applying: ARM: dts: Add Exynos5250 Snow Rev5+ support
.git/rebase-apply/patch:774: new blank line at EOF.
+
warning: 1 line adds whitespace errors.


One other nit is that the exynos5250-snow.dts" ends up with the
"max98095" pinctrl properties sorted differently than the
"exynos5250-snow-rev5.dts".  Is it worth reordering the
"exynos5250-snow.dts" in the same patch?

Otherwise this looks fine to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
