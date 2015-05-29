From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 29 May 2015 18:33:42 +0200
Subject: [PATCH/RFC 1/2] ARM: multi_v7_defconfig: Make drm support modular
In-Reply-To: <2568731.dqdEiMuDro@wuerfel>
References: <1432905926-31606-1-git-send-email-geert@linux-m68k.org>
 <2568731.dqdEiMuDro@wuerfel>
Message-ID: <CAMuHMdVKjgNEUot44E45Q1UWCgUC6zOM5mLhBr0qWuXRim3DsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 5:41 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 29 May 2015 15:25:25 Geert Uytterhoeven wrote:
>> From: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> Make drm support modular to reduce kernel size (-620 KiB):
>>
>>        text    data     bss     dec     hex   filename
>>     12211122 1392076  338520 13941718  d4bbd6 vmlinux.before
>>     11581470 1387196  338264 13306930  cb0c32 vmlinux.after
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Slightly controversial:
>>   - Does anyone need drm for boot testing?
>
> Only the tegra driver is affected, so let's ask the tegra
> maintainers.

And the qcom maintainers.

CONFIG_DRM_MSM also changes from m to y, but this is not visible in
multi_v7_defconfig due to CONFIG_DRM_MSM_FBDEV=y and defconfig reduction...

>>  arch/arm/configs/multi_v7_defconfig | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index 40ca1ab29a2e350f..9b4e33d5b15e340f 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -426,15 +426,17 @@ CONFIG_VIDEO_RENESAS_VSP1=m
>>  # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
>>  CONFIG_VIDEO_ADV7180=m
>>  CONFIG_VIDEO_ML86V7667=m
>> -CONFIG_DRM=y
>> +CONFIG_TEGRA_HOST1X=y
>> +CONFIG_DRM=m
>>  CONFIG_DRM_PTN3460=m
>>  CONFIG_DRM_PS8622=m
>>  CONFIG_DRM_EXYNOS=m
>>  CONFIG_DRM_EXYNOS_FIMD=y
>>  CONFIG_DRM_EXYNOS_HDMI=y
>>  CONFIG_DRM_RCAR_DU=m
>> -CONFIG_DRM_TEGRA=y
>> -CONFIG_DRM_PANEL_SIMPLE=y
>> +CONFIG_DRM_TEGRA=m
>> +CONFIG_DRM_PANEL_SIMPLE=m
>> +CONFIG_FB=y
>>  CONFIG_FB_ARMCLCD=y
>>  CONFIG_FB_WM8505=y
>>  CONFIG_FB_SH_MOBILE_LCDC=y

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
