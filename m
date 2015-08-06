From: ykk@rock-chips.com (Yakir Yang)
Date: Thu, 6 Aug 2015 23:00:47 +0800
Subject: [RFC PATCH 0/8] Add Analogix Core Display Port Driver
In-Reply-To: <000201d0d056$06cff040$146fd0c0$@com>
References: <1438868947-22132-1-git-send-email-ykk@rock-chips.com>
 <000201d0d056$06cff040$146fd0c0$@com>
Message-ID: <55C3769F.2010405@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jingoo,

? 2015/8/6 22:41, Jingoo Han ??:
> On Thursday, August 06, 2015 10:49 PM, Yakir Yang wrote:
>> Hi all,
>>     Samsung exynos and Rockchip rk3288 almost share same dp controller,
>> so I split the common code out, then rk3288 and exynos can re-used the
>> same dp core driver. Cause I can't find the exact IP name of exynos dp
>> controller, so I decide to name dp core driver with "analogix" which I
>> find in rk3288 eDP TRM ;)
>
> OK, I see.
> The Samsung Exynos eDP contoller and Rockchip rk3288 eDP contoller share
> the same IP. So, a lot of parts can be re-used. I agree with this.
> However, we have to review the code carefully, as others did.
Yeah, feel happy to be reviewed  ;)

> I also cannot find the exact IP name. The "analogix" may be the vendor name
> of this IP.
Okay, so "analogix" is okay for now

Thanks,
- Yakir
> Best regards,
> Jingoo Han
>
>> Beyond that, there are three light registers setting differents bewteen
>> exynos and rk3288.
>> 1. RK3288 have five special pll resigters which not indicata in exynos
>>     dp controller.
>> 2. The address of DP_PHY_PD(dp phy power manager register) are different
>>     between rk3288 and exynos.
>> 3. Rk3288 and exynos have different setting with AUX_HW_RETRY_CTL(dp debug
>>     register).
>>
>> My series patches can be divider into two parts: One for spliting the
>> analogix_dp code from exynos dp driver. Another are trying to add rk3288
>> dp driver support.
>>
>> Best regards,
>> - Yakir
>>
>>
>> --
>> 2.1.2
>
>
>
>
