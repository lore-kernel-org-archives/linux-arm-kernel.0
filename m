From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 14 Mar 2017 16:18:23 +0200
Subject: [PATCH 1/3] arm64: defconfig: Enable DRM and LPASS drivers for
 Exynos5433 and Exynos7
In-Reply-To: <2818068.EPOAvXIH6Z@amdc3058>
References: <20170311213856.21701-1-krzk@kernel.org>
 <CGME20170314141613epcas5p30fa91bf723a5e3a8f11ce9a8cfdb7dd7@epcas5p3.samsung.com>
 <20170311213856.21701-2-krzk@kernel.org> <2818068.EPOAvXIH6Z@amdc3058>
Message-ID: <CAJKOXPf5D+=Qdmbr03yCXcRiSbmfBJbd1T2HnKfsg5huQSQShA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 4:16 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Hi,
>
> On Saturday, March 11, 2017 11:38:54 PM Krzysztof Kozlowski wrote:
>> Enable drivers specific to Exynos5433 and Exynos7:
>> 1. MFD Low Power Audio SubSystem (LPASS),
>> 2. Entire DRM stack (display, outputs, additional sub-blocks),
>> 3. Drivers for video-related sub-blocks (JPEG, Multi Format Codec,
>>    GScaler).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>  arch/arm64/configs/defconfig | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 5e7fa211eb0a..81515cbd2fe8 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -302,6 +302,7 @@ CONFIG_RENESAS_WDT=y
>>  CONFIG_S3C2410_WATCHDOG=y
>>  CONFIG_MESON_GXBB_WATCHDOG=m
>>  CONFIG_MESON_WATCHDOG=m
>> +CONFIG_MFD_EXYNOS_LPASS=m
>>  CONFIG_MFD_MAX77620=y
>>  CONFIG_MFD_RK808=y
>>  CONFIG_MFD_SPMI_PMIC=y
>> @@ -327,10 +328,27 @@ CONFIG_MEDIA_CONTROLLER=y
>>  CONFIG_VIDEO_V4L2_SUBDEV_API=y
>>  # CONFIG_DVB_NET is not set
>>  CONFIG_V4L_MEM2MEM_DRIVERS=y
>> +CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
>> +CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
>> +CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
>>  CONFIG_VIDEO_RENESAS_FCP=m
>>  CONFIG_VIDEO_RENESAS_VSP1=m
>>  CONFIG_DRM=m
>>  CONFIG_DRM_NOUVEAU=m
>> +CONFIG_DRM_EXYNOS=m
>> +CONFIG_DRM_EXYNOS_FIMD=y
>> +CONFIG_DRM_EXYNOS5433_DECON=y
>> +CONFIG_DRM_EXYNOS7_DECON=y
>> +CONFIG_DRM_EXYNOS_MIXER=y
>> +CONFIG_DRM_EXYNOS_VIDI=y
>> +CONFIG_DRM_EXYNOS_DPI=y
>> +CONFIG_DRM_EXYNOS_DSI=y
>> +CONFIG_DRM_EXYNOS_HDMI=y
>> +CONFIG_DRM_EXYNOS_MIC=y
>> +CONFIG_DRM_EXYNOS_G2D=y
>> +CONFIG_DRM_EXYNOS_IPP=y
>> +CONFIG_DRM_EXYNOS_FIMC=y
>> +CONFIG_DRM_EXYNOS_ROTATOR=y
>
> I would prefer to enable only sub-drivers that are actually
> used on Exynos5433/Exynos7 hardware, i.e. currently only
> exynos4.dtsi uses compatibles for FIMC and rotator drivers
> (I have not checked all sub-drivers).

I thought I enabled only these which are present but apparently I went
too far. I'll fix it up. Thanks for review!

Best regards,
Krzysztof
