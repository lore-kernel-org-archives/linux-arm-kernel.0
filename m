From: mark.yao@rock-chips.com (Mark yao)
Date: Fri, 10 Jul 2015 15:11:35 +0800
Subject: [PATCH] drm: Drop owner assignment from i2c_driver
In-Reply-To: <559F6DB6.9010000@samsung.com>
References: <1436506597-1096-1-git-send-email-k.kozlowski@samsung.com>
 <1436506597-1096-2-git-send-email-k.kozlowski@samsung.com>
 <559F6B3C.8080908@rock-chips.com> <559F6DB6.9010000@samsung.com>
Message-ID: <559F7027.6010602@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?07?10? 15:01, Krzysztof Kozlowski wrote:
> On 10.07.2015 15:50, Mark yao wrote:
>> On 2015?07?10? 13:36, Krzysztof Kozlowski wrote:
>>> i2c_driver does not need to set an owner because i2c_register_driver()
>>> will set it.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>
>>> ---
>>>
>>> The coccinelle script which generated the patch was sent here:
>>> http://www.spinics.net/lists/kernel/msg2029903.html
>>> ---
>>>    drivers/gpu/drm/bridge/ps8622.c             | 1 -
>>>    drivers/gpu/drm/bridge/ptn3460.c            | 1 -
>>>    drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 1 -
>>>    3 files changed, 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/ps8622.c
>>> b/drivers/gpu/drm/bridge/ps8622.c
>>> index 1a6607beb29f..be881e9fef8f 100644
>>> --- a/drivers/gpu/drm/bridge/ps8622.c
>>> +++ b/drivers/gpu/drm/bridge/ps8622.c
>>> @@ -668,7 +668,6 @@ static struct i2c_driver ps8622_driver = {
>>>        .remove        = ps8622_remove,
>>>        .driver        = {
>>>            .name    = "ps8622",
>>> -        .owner    = THIS_MODULE,
>>>            .of_match_table = ps8622_devices,
>>>        },
>>>    };
>>> diff --git a/drivers/gpu/drm/bridge/ptn3460.c
>>> b/drivers/gpu/drm/bridge/ptn3460.c
>>> index 1b1bf2384815..0ffa3a6a206a 100644
>>> --- a/drivers/gpu/drm/bridge/ptn3460.c
>>> +++ b/drivers/gpu/drm/bridge/ptn3460.c
>>> @@ -400,7 +400,6 @@ static struct i2c_driver ptn3460_driver = {
>>>        .remove        = ptn3460_remove,
>>>        .driver        = {
>>>            .name    = "nxp,ptn3460",
>>> -        .owner    = THIS_MODULE,
>>>            .of_match_table = ptn3460_match,
>>>        },
>>>    };
>>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
>>> b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
>>> index 01b558fe3695..9a0c2911272a 100644
>>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
>>> @@ -555,7 +555,6 @@ static struct platform_driver
>>> rockchip_drm_platform_driver = {
>>>        .probe = rockchip_drm_platform_probe,
>>>        .remove = rockchip_drm_platform_remove,
>>>        .driver = {
>>> -        .owner = THIS_MODULE,
>> But rockchip drm is platform driver not i2c_driver, why remove its .owner ?
> Oh, indeed. Thanks for spotting this.
>
> The 'owner' is set by core for platform drivers as well. Most platform
> drivers were already converted (I think by Wolfram Sang). I extended
> existing coccinelle script to fix also i2c_drivers and sometimes did not
> notice that it was platform_driver.
>
> I can split it into two different patches. Would that be ok?
>
> Best regards,
> Krzysztof
>
Ok, Thanks for the fix.:-)

-- 
?ark
