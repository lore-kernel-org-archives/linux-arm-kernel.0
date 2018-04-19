From: hjc@rock-chips.com (Sandy Huang)
Date: Thu, 19 Apr 2018 21:14:23 +0800
Subject: [PATCH] drm/rockchip: vop: fixup linebuffer mode calc error
In-Reply-To: <2475172.s4GHAT5PDW@phil>
References: <1523960108-190541-1-git-send-email-hjc@rock-chips.com>
 <2475172.s4GHAT5PDW@phil>
Message-ID: <10983760-1c4a-d4e2-be63-7684d87fc4b1@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018/4/17 19:14, Heiko Stuebner ??:
> Hi Sandy,
> 
> Am Dienstag, 17. April 2018, 12:15:07 CEST schrieb Sandy Huang:
>> When video width is bigger than 3840 the linebuffer mode
>> should be LB_YUV_3840X5.
> 
> Can you explain that a bit better?
> 
> I.e. when looking at the code, the very first check is width > 2560.
> 
> So it seems your change targets some YUV mode with width > 3840
> which should be mentioned in the commit message, so people like
> me don't scratch their head in confusion ;-)
> 
> Similarly that check is actually width > 1280 to set LB_YUV_3840X5,
> so I guess you're actually wanting any YUV mode bigger than
> 1280px should use LB_YUV_3840X5?
> 
> 
> Heiko
> 

Thanks heiko,
I will make more description for this path at next version.

>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
>> ---
>>   drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
>> index 56bbd2e..3e7501b 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
>> @@ -332,7 +332,7 @@ static inline int scl_vop_cal_lb_mode(int width, bool is_yuv)
>>   
>>   	if (width > 2560)
>>   		lb_mode = LB_RGB_3840X2;
>> -	else if (width > 1920)
>> +	else if (!is_yuv && width > 1920)
>>   		lb_mode = LB_RGB_2560X4;
>>   	else if (!is_yuv)
>>   		lb_mode = LB_RGB_1920X5;
>>
> 
> 
> 
> 
> 
