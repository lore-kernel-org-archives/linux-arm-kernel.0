From: mark.yao@rock-chips.com (Mark yao)
Date: Thu, 02 Jul 2015 15:03:34 +0800
Subject: [PATCH] drm/rockchip: vop: remove hardware cursor window
In-Reply-To: <1617606.rtBNOYcypX@diego>
References: <1435744173-23112-1-git-send-email-mark.yao@rock-chips.com>
 <1617606.rtBNOYcypX@diego>
Message-ID: <5594E246.6090500@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?07?01? 19:52, Heiko St?bner wrote:
> Hi Mark,
>
> Am Mittwoch, 1. Juli 2015, 17:49:33 schrieb Mark Yao:
>> hardware cursor windows only have some fixed size, and not support
>> width virtual, when move hardware cursor windows outside of left,
>> the display would be wrong, so this window can't for cursor now.
>>
>> And Tag hardware cursor window as a overlay is wrong, will make
>> userspace wrong behaviour.
>>
>> So just remove the hardware cursor window
>>
>> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
>> ---
>>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c |    1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c index 4603412..7373ba1 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> @@ -368,7 +368,6 @@ static const struct vop_win_data rk3288_vop_win_data[] =
>> { { .base = 0x40, .phy = &win01_data, .type = DRM_PLANE_TYPE_OVERLAY }, {
>> .base = 0x00, .phy = &win23_data, .type = DRM_PLANE_TYPE_OVERLAY }, { .base
>> = 0x50, .phy = &win23_data, .type = DRM_PLANE_TYPE_CURSOR }, -	{ .base =
>> 0x00, .phy = &cursor_data, .type = DRM_PLANE_TYPE_OVERLAY }, };
>>
>>   static const struct vop_data rk3288_vop = {
> you should probably also remove the
>
> 	static const struct vop_win_phy cursor_data
>
> completely then, as it is now unused?
>
>
> Heiko
>
>
>
OK

-- 
?ark
