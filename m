From: dianders@chromium.org (Doug Anderson)
Date: Mon, 21 Apr 2014 12:35:49 -0700
Subject: [PATCH 7/7] ARM: tegra: Add the EC i2c tunnel to tegra124-venice2
In-Reply-To: <535560E9.5040108@wwwdotorg.org>
References: <1397757570-19750-1-git-send-email-dianders@chromium.org>
 <1397757570-19750-8-git-send-email-dianders@chromium.org>
 <535560E9.5040108@wwwdotorg.org>
Message-ID: <CAD=FV=W8=SLxF=goYm9p3Dr0ZQYy9FzN0hbE+MwWFYGarZB9tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

On Mon, Apr 21, 2014 at 11:18 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/17/2014 11:59 AM, Doug Anderson wrote:
>> This adds the EC i2c tunnel (and devices under it) to the
>> tegra124-venice2 device tree.
>
> The series,
> Tested-by: Stephen Warren <swarren@nvidia.com>
>
> I can apply this one patch once the other patches in the series are
> acked or applied (in order to make sure the DT binding is acceptable to
> others).

Sounds good.  If I don't get any feedback (positive or negative) in
the next few days I'll resend with your Tested-by.


> I guess I'll send separate patches for tegra_defconfig and
> multi_v7_defconfig to add the required options once I've applied this,
> unless you beat me to it.
>
>> diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
>
>>       aliases {
>> +             i2c20 = "/spi at 0,7000d400/cros-ec at 0/i2c-tunnel";
>
> Is that needed? I'd prefer not to add it unless there's a specific
> reason. I don't think I2C buses need specific names, do they?

It is not strictly needed, but from a usability standpoint it is
terribly helpful.  It serves to make it obvious to someone looking at
the device that it's _not_ an i2c bus associated with the main SoC.
If you don't include a number I believe that the i2c core will pick
the first available number.

It seems worth it to save a few people a few hours of head scratching.

...but this is your dts and if you think it's a terrible idea then
I'll remove it.  It looks to be less critical on tegra than it is on
exynos (which has ~9 i2c busses, they are numbered in the user manual,
and if you have one set to "disable" in the dts then the tunnel will
end up getting a very confusing number).

-Doug
