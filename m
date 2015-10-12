From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 12 Oct 2015 15:20:27 +0800
Subject: [PATCH v7 05/17] drm: bridge: analogix/dp: dynamic parse sync_pol
 & interlace & dynamic_range
In-Reply-To: <561B590B.6090806@samsung.com>
References: <1444491357-26095-1-git-send-email-ykk@rock-chips.com>
 <1444624149-16180-1-git-send-email-ykk@rock-chips.com>
 <561B590B.6090806@samsung.com>
Message-ID: <561B5F3B.4020005@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/12/2015 02:54 PM, Krzysztof Kozlowski wrote:
> On 12.10.2015 13:29, Yakir Yang wrote:
>> Both hsync/vsync polarity and interlace mode can be parsed from
>> drm display mode, and dynamic_range and ycbcr_coeff can be judge
>> by the video code.
>>
>> But presumably Exynos still relies on the DT properties, so take
>> good use of mode_fixup() in to achieve the compatibility hacks.
>>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> ---
>> *just add a note that this is v7 of only fifth patch.*
>>
>> Changes in v7:
>> - Back to use the of_property_read_bool() interfacs to provoid backward
>>    compatibility of "hsync-active-high" "vsync-active-high" "interlaced"
>>    to avoid -EOVERFLOW error (Krzysztof)
>>
>> Changes in v6: None
>> Changes in v5:
>> - Switch video timing type to "u32", so driver could use "of_property_read_u32"
>>    to get the backword timing values. Krzysztof suggest me that driver could use
>>    the "of_property_read_bool" to get backword timing values, but that interfacs
>>    would modify the original drm_display_mode timing directly (whether those
>>    properties exists or not).
>>
>> Changes in v4:
>> - Provide backword compatibility with samsung. (Krzysztof)
>>
>> Changes in v3:
>> - Dynamic parse video timing info from struct drm_display_mode and
>>    struct drm_display_info. (Thierry)
>>
>> Changes in v2: None
>>
>>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 148 +++++++++++++--------
>>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |   2 +-
>>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  |  14 +-
>>   3 files changed, 103 insertions(+), 61 deletions(-)
>>
> Looks good and backward compatible to me:
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Thanks,

- Yakir

> Best regards,
> Krzysztof
>
>
>
>
