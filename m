From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 19 Aug 2015 20:02:57 -0500
Subject: [PATCH v3 0/14] Add Analogix Core Display Port Driver
In-Reply-To: <CAPM=9tx6qMnHEfYpi5_+Ay9P5fy=JqthMp6-t0fxFPfm8E4k7Q@mail.gmail.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <CAPM=9tx6qMnHEfYpi5_+Ay9P5fy=JqthMp6-t0fxFPfm8E4k7Q@mail.gmail.com>
Message-ID: <55D52741.3080709@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On 08/19/2015 06:54 PM, Dave Airlie wrote:
> On 20 August 2015 at 00:48, Yakir Yang <ykk@rock-chips.com> wrote:
>> Hi all,
>>     The Samsung Exynos eDP controller and Rockchip RK3288 eDP controller
>> share the same IP, so a lot of parts can be re-used. I split the common
>> code into bridge directory, then rk3288 and exynos only need to keep
>> some platform code. Cause I can't find the exact IP name of exynos dp
>> controller, so I decide to name dp core driver with "analogix" which I
>> find in rk3288 eDP TRM ;)
>>
>> Beyond that, there are three light registers setting differents bewteen
>> exynos and rk3288.
>> 1. RK3288 have five special pll resigters which not indicata in exynos
>>     dp controller.
>> 2. The address of DP_PHY_PD(dp phy power manager register) are different
>>     between rk3288 and exynos.
>> 3. Rk3288 and exynos have different setting with AUX_HW_RETRY_CTL(dp debug
>>     register).
>>
>> I have verified this series on two kinds of rockchip platform board, one
>> is rk3288 sdk board which connect with a 2K display port monitor, the other
>> is google jerry chromebook which connect with a eDP screen "cnm,n116bgeea2",
>> both of them works rightlly.
>>
>> I haven't verified the dp function on samsung platform, cause I haven't got
>> exynos boards. I can only ensure that there are no build error on samsung
>> platform, wish some samsung guys help to test. ;)
> I'd like to pull this in, but it probably needs an ack from Samsung,
>
> Inki can you guys find some time to test this?
>
> Dave.

Wow, thanks a lots  :-)

Still waiting for some reviews and acks.

Best regards,
- Yakir
>
>
