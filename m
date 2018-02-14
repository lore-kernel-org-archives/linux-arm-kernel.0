From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 14 Feb 2018 18:28:44 +0100
Subject: [PATCH] drm: exynos: Use proper macro definition for
 HDMI_I2S_PIN_SEL_1
In-Reply-To: <5A83CFB4.6000207@samsung.com>
References: <CGME20180205174229epcas1p1e15e6f8ef5248ee28fa2e649faa8a866@epcas1p1.samsung.com>
 <20180205174212.10791-1-s.nawrocki@samsung.com>
 <5A83CFB4.6000207@samsung.com>
Message-ID: <d5b08d95-bec9-8691-6814-66c26752ac87@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Inki,

On 02/14/2018 06:57 AM, Inki Dae wrote:
>> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
>> index a4b75a46f946..abd84cbcf1c2 100644
>> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
>> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
>> @@ -1068,10 +1068,13 @@ static void hdmi_audio_config(struct hdmi_context *hdata)
>>  	/* Configuration I2S input ports. Configure I2S_PIN_SEL_0~4 */
>>  	hdmi_reg_writeb(hdata, HDMI_I2S_PIN_SEL_0, HDMI_I2S_SEL_SCLK(5)
>>  			| HDMI_I2S_SEL_LRCK(6));
>> -	hdmi_reg_writeb(hdata, HDMI_I2S_PIN_SEL_1, HDMI_I2S_SEL_SDATA1(1)
>> -			| HDMI_I2S_SEL_SDATA2(4));
>> +
>> +	hdmi_reg_writeb(hdata, HDMI_I2S_PIN_SEL_1, HDMI_I2S_SEL_SDATA1(3)
>
> Seems you fixed pin_sel_3 field value of I2S_PIN_SEL_1 register. According 
> to datasheet, 0x3 should be set to this field to select SDATA_1 not 0x1.
> So could you update the description of this patch?

Indeed, I finally missed that when I was writing the commit message. 
I've posted v2 already.

-- 
Regards,
Sylwester
