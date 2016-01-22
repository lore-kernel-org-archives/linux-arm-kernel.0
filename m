From: ykk@rock-chips.com (Yakir Yang)
Date: Fri, 22 Jan 2016 09:37:08 +0800
Subject: [PATCH v12.1 07/17] drm: rockchip: dp: add rockchip platform dp
 driver
In-Reply-To: <7132332.jmLRiUjx3U@phil>
References: <1450873538-18304-1-git-send-email-ykk@rock-chips.com>
 <1453197893-13413-1-git-send-email-ykk@rock-chips.com>
 <7132332.jmLRiUjx3U@phil>
Message-ID: <56A187C4.2030100@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 01/22/2016 03:11 AM, Heiko Stuebner wrote:
> Hi Yakir,
>
> Am Dienstag, 19. Januar 2016, 18:04:53 schrieb Yakir Yang:
>> Rockchip have three clocks for dp controller, we leave pclk_edp
>> to analogix_dp driver control, and keep the sclk_edp_24m and
>> sclk_edp in platform driver.
>>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> ---
> [...]
>
>> +static int rockchip_dp_drm_create_encoder(struct rockchip_dp_device *dp)
>> +{
>> +	struct drm_encoder *encoder = &dp->encoder;
>> +	struct drm_device *drm_dev = dp->drm_dev;
>> +	struct device *dev = dp->dev;
>> +	int ret;
>> +
>> +	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
>> +							     dev->of_node);
>> +	DRM_DEBUG_KMS("possible_crtcs = 0x%x\n", encoder->possible_crtcs);
>> +
>> +	ret = drm_encoder_init(drm_dev, encoder, &rockchip_dp_encoder_funcs,
>> +			       DRM_MODE_ENCODER_TMDS);
> should be
> +			       DRM_MODE_ENCODER_TMDS, NULL);

Ops,  :-|

> Exynos-side seems to be ok though.
>
> With the adapted v12.1 patches it applies cleanly and display is working as
> well. So with the thing above fixed, you could resubmit a full v13,
> especially as you want to drop patch 16 as discussed there.

Got it :)

Thanks,
Yakir
>
> Heiko
>
>
>
