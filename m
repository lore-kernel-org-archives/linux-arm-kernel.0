From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 30 Sep 2015 16:02:36 +0900
Subject: [PATCH] ARM: dts: Add Exynos5250 Snow Rev5+ support
In-Reply-To: <560B8818.8020002@kernel.org>
References: <1443527855-434-1-git-send-email-javier@osg.samsung.com>
 <560B2D29.5060707@samsung.com> <560B8818.8020002@kernel.org>
Message-ID: <560B890C.3060200@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.09.2015 15:58, Kukjin Kim wrote:
> On 09/30/15 09:30, Krzysztof Kozlowski wrote:
>> On 29.09.2015 20:57, Javier Martinez Canillas wrote:
>>> There are 2 revisions of the Exynos5250 Snow Chromebook that were shipped:
>>> Rev4 and Rev5. The only difference between these 2 revisions is the codec,
>>> Rev4 has a max98095 codec while Rev5 has a max98090.
>>>
>>> Mainline only supports Rev4 so this patch moves the common device nodes to
>>> a DTSI file and adds a DTS for the Exynos5250 Snow Rev5.
>>>
>>> The Snow Rev5 DTS is based on the DTS found in the ChromiumOS 3.8 tree.
>>>
>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>>
>>> ---
>>>
>>> The DTS in the vendor ChromeOS tree are called exynos5250-snow-rev{4,5}.dtb
>>> but I decided to leave Rev4 as exynos5250-snow.dtb to avoid breaking u-boot
>>> that has CONFIG_DEFAULT_DEVICE_TREE="exynos5250-snow" in snow_defconfig.
>>>
>>> Also, ChromiumOS Rev4 DTS has "google,snow-rev4" in its compatible string
>>> but was not added in mainline since Rev4 firmware fallbacks to "google,snow"
>>> and Rev5 searches for "google,snow-rev5". That way the compatible string
>>> could be consistent with the DTS naming and still be able to pack both Rev4
>>> and Rev5 FDT in the same FIT image and let the firmware pick the correct FDT.
>>>
>>>  arch/arm/boot/dts/Makefile                    |   1 +
>>>  arch/arm/boot/dts/exynos5250-snow-common.dtsi | 684 ++++++++++++++++++++++++++
>>>  arch/arm/boot/dts/exynos5250-snow-rev5.dts    |  47 ++
>>>  arch/arm/boot/dts/exynos5250-snow.dts         | 666 +------------------------
>>>  4 files changed, 733 insertions(+), 665 deletions(-)
>>>  create mode 100644 arch/arm/boot/dts/exynos5250-snow-common.dtsi
>>>  create mode 100644 arch/arm/boot/dts/exynos5250-snow-rev5.dts
>>
>> Now the exynos5250-snow.dts means in fact Rev4... but there is no
>> information in DTS about it. I think adding compatible
>> "google,snow-rev4" makes sense:
>> 1. For informational purposes (this could be also handled with a comment).
>> 2. Later one could decide to switch the default meaning of "google,snow"
>> to Rev5 and the real compatible (rev4) will be there already.
>>
>> Could you add the new compatible and fix patch issues pointed by Doug?
>>
> Documenting for the compatibles would be required even I already applied
> its updated patch...

What do you mean by "documenting compatibles"? These are board
compatibles, they are not documented...

Best regards,
Krzysztof
