From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 30 Sep 2015 08:42:10 +0200
Subject: [PATCH] ARM: dts: Add Exynos5250 Snow Rev5+ support
In-Reply-To: <560B2D29.5060707@samsung.com>
References: <1443527855-434-1-git-send-email-javier@osg.samsung.com>
 <560B2D29.5060707@samsung.com>
Message-ID: <560B8442.1070901@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 09/30/2015 02:30 AM, Krzysztof Kozlowski wrote:

[snip]

>>
>> The DTS in the vendor ChromeOS tree are called exynos5250-snow-rev{4,5}.dtb
>> but I decided to leave Rev4 as exynos5250-snow.dtb to avoid breaking u-boot
>> that has CONFIG_DEFAULT_DEVICE_TREE="exynos5250-snow" in snow_defconfig.
>>
>> Also, ChromiumOS Rev4 DTS has "google,snow-rev4" in its compatible string
>> but was not added in mainline since Rev4 firmware fallbacks to "google,snow"
>> and Rev5 searches for "google,snow-rev5". That way the compatible string
>> could be consistent with the DTS naming and still be able to pack both Rev4
>> and Rev5 FDT in the same FIT image and let the firmware pick the correct FDT.
>>
>>  arch/arm/boot/dts/Makefile                    |   1 +
>>  arch/arm/boot/dts/exynos5250-snow-common.dtsi | 684 ++++++++++++++++++++++++++
>>  arch/arm/boot/dts/exynos5250-snow-rev5.dts    |  47 ++
>>  arch/arm/boot/dts/exynos5250-snow.dts         | 666 +------------------------
>>  4 files changed, 733 insertions(+), 665 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/exynos5250-snow-common.dtsi
>>  create mode 100644 arch/arm/boot/dts/exynos5250-snow-rev5.dts
> 
> Now the exynos5250-snow.dts means in fact Rev4... but there is no
> information in DTS about it. I think adding compatible
> "google,snow-rev4" makes sense:
> 1. For informational purposes (this could be also handled with a comment).
> 2. Later one could decide to switch the default meaning of "google,snow"
> to Rev5 and the real compatible (rev4) will be there already.
>

Ok, I explained my rationale about why I did not add a "google,snow-rev4"
but I don't have a strong opinion on this so I'll add it on v2.
 
> Could you add the new compatible and fix patch issues pointed by Doug?
>

Sure.

> Best regards,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
