From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 30 Sep 2015 14:52:23 +0800
Subject: [PATCH v5 03/17] drm: bridge: analogix/dp: fix some obvious code
 style
In-Reply-To: <560B719A.4040309@samsung.com>
References: <1442906428-2609-1-git-send-email-ykk@rock-chips.com>
 <1442907276-2997-1-git-send-email-ykk@rock-chips.com>
 <560B719A.4040309@samsung.com>
Message-ID: <560B86A7.3090100@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 09/30/2015 01:22 PM, Krzysztof Kozlowski wrote:
> On 22.09.2015 16:34, Yakir Yang wrote:
>> Fix some obvious alignment problems, like alignment and line
>> over 80 characters problems, make this easy to be maintained
>> later.
>>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> ---
>> Changes in v5:
>> - Resequence this patch after analogix_dp driver have been split
>>    from exynos_dp code, and rephrase reasonable commit message, and
>>    remove some controversial style (Krzysztof)
>>      -		analogix_dp_write_byte_to_dpcd(
>>      - 				dp, DP_TEST_RESPONSE,
>>      +		analogix_dp_write_byte_to_dpcd(dp,
>>      +				DP_TEST_RESPONSE,
>> 				DP_TEST_EDID_CHECKSUM_WRITE);
>>
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2:
>> - Improved commit message more readable, and avoid using some
>>    uncommon style like bellow: (Joe Preches)
>>      -  retval = exynos_dp_read_bytes_from_i2c(...
>>    				  ...);
>>      +  retval =
>>      +  exynos_dp_read_bytes_from_i2c(......);
>>
>>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 129 ++++++++++-----------
>>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  72 ++++++------
>>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  | 124 ++++++++++----------
>>   3 files changed, 163 insertions(+), 162 deletions(-)
>>
> IMHO much better than in previous attempt. The code looks good:
>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
> BTW my opinion is not enough, you still need an ack from Exynos DP
> maintainer (or DRM guys).

Aha, thanks.

- Yakir

> Best regards,
> Krzysztof
>
>
>
>
