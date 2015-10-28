From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 28 Oct 2015 10:08:21 +0800
Subject: [PATCH v7 06/17] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <4132920.kfrKzY5nYN@phil>
References: <1445599415-30856-1-git-send-email-ykk@rock-chips.com>
 <1445655964-15237-1-git-send-email-ykk@rock-chips.com>
 <4132920.kfrKzY5nYN@phil>
Message-ID: <56302E15.1060408@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 10/28/2015 05:04 AM, Heiko Stuebner wrote:
> Hi Yakir,
>
> Am Samstag, 24. Oktober 2015, 11:06:00 schrieb Yakir Yang:
>> Analogix dp driver is split from exynos dp driver, so we just
>> make an copy of exynos_dp.txt, and then simplify exynos_dp.txt
>>
>> Beside update some exynos dtsi file with the latest change
>> according to the devicetree binding documents.
>>
>> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> ---
>> diff --git a/Documentation/devicetree/bindings/display/exynos/exynos_dp.txt b/Documentation/devicetree/bindings/display/exynos/exynos_dp.txt
>> index 7a3a9cd..9e47357 100644
>> --- a/Documentation/devicetree/bindings/display/exynos/exynos_dp.txt
>> +++ b/Documentation/devicetree/bindings/display/exynos/exynos_dp.txt
>> @@ -31,45 +31,31 @@ Required properties for dp-controller:
>>   		from general PHY binding: the phandle for the PHY device.
>>   	-phy-names:
>>   		from general PHY binding: Should be "dp".
>> -	-samsung,color-space:
>> -		input video data format.
>> -			COLOR_RGB = 0, COLOR_YCBCR422 = 1, COLOR_YCBCR444 = 2
>> -	-samsung,dynamic-range:
>> -		dynamic range for input video data.
>> -			VESA = 0, CEA = 1
>> -	-samsung,ycbcr-coeff:
>> -		YCbCr co-efficients for input video.
>> -			COLOR_YCBCR601 = 0, COLOR_YCBCR709 = 1
>> -	-samsung,color-depth:
>> -		number of bits per colour component.
>> -			COLOR_6 = 0, COLOR_8 = 1, COLOR_10 = 2, COLOR_12 = 3
>> -	-samsung,link-rate:
>> -		link rate supported by the panel.
>> -			LINK_RATE_1_62GBPS = 0x6, LINK_RATE_2_70GBPS = 0x0A
>> -	-samsung,lane-count:
>> -		number of lanes supported by the panel.
>> -			LANE_COUNT1 = 1, LANE_COUNT2 = 2, LANE_COUNT4 = 4
>> +
>> +Optional properties for dp-controller:
>>   	- display-timings: timings for the connected panel as described by
>>   		Documentation/devicetree/bindings/video/display-timing.txt
> 											^^
>
> bindings/display/display-timing.txt ... that actually made the patch not apply cleanly

Thanks, the right path should be:
Documentation/devicetree/bindings/display/panel/display-timing.txt


>
> [...]
>
>> -[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
>> +Deprecated properties for DisplayPort:
>> +-interlaced:            deprecated prop that can parsed frm drm_display_mode.
>> +-vsync-active-high:     deprecated prop that can parsed frm drm_display_mode.
>> +-hsync-active-high:     deprecated prop that can parsed frm drm_display_mode.
>> +-samsung,ycbcr-coeff:   deprecated prop that can parsed frm drm_display_mode.
>> +-samsung,dynamic-range: deprecated prop that can parsed frm drm_display_mode.
> the "frm" above need some more "o"s to be "from"s :-)

Ah,  :-P

Thanks,
- Yakir
>
>> +-samsung,color-space:   deprecated prop that can parsed from drm_display_info.
>> +-samsung,color-depth:   deprecated prop that can parsed from drm_display_info.
>> +-samsung,link-rate:     deprecated prop that can reading from monitor by dpcd method.
>> +-samsung,lane-count:    deprecated prop that can reading from monitor by dpcd method.
>> +-samsung,hpd-gpio:      deprecated name for hpd-gpios.
>> +
>> +-------------------------------------------------------------------------------
>
> Cheers,
> Heiko
>
>
>
