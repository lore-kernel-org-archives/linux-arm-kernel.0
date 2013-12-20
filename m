From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Fri, 20 Dec 2013 17:08:48 +0530
Subject: [PATCH 1/2] ARM: EXYNOS: Support Suspend-to-RAM on EXYNOS5420
In-Reply-To: <CANruHrS1D8d_y43xa-2OGduTvAGWfdeY1REVzZ6YJHjhzLg+hw@mail.gmail.com>
References: <1387195271-3613-1-git-send-email-a.kesavan@samsung.com>
 <2459303.277Jr8aotM@amdc1032>
 <CAM4voamU5hc7uC5MTOA7OtYuqpsis7cTX3sx0UrmpdZx7_TpzA@mail.gmail.com>
 <CANruHrS1D8d_y43xa-2OGduTvAGWfdeY1REVzZ6YJHjhzLg+hw@mail.gmail.com>
Message-ID: <CAM4voamD4Cj594fbkciNS32U7PSkByxakZmjPnhFo0mpCj8hug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sunil,

On Fri, Dec 20, 2013 at 3:56 PM, sunil joshi <sjoshi.open@gmail.com> wrote:
> Hi Abhilash,
> I saw another patch in chrome tree ..by Andrew Bresticker
> which may be relevant here ..
>
> Just wondering if you missed adding this ? or this is not needed ?
> You did not face any issue in getting core to suspend ?

This has not been added for Exynos5250 in mainline yet. We did notice
that the system would fail to suspend on the rare occasion (~1% of the
time on exynos5250) when we repeatedly suspended and resumed the
system.

I have not run s2r stress tests, but have had no issues suspending the
system in my limited testing. We can probably let this be for now as
the system would resume fine even on a failed suspend. I will do some
stress testing and then post if needed.
>
> ------------------------------------------------------------------------------------------
> commit 95402d816b9f1a05ce633f7ff64b4c939c142482
> Author: Andrew Bresticker <abrestic@chromium.org>
> Date:   Mon Jul 15 13:14:36 2013 -0700
>
>     arm: exynos: disable all interrupts on Exynos5420 before suspend
>
>     Disable all interrupts from the GIC before entering suspend on
>     Exynos5420 as is done on Exynos5250.  If interrupts are enabled, we
>     may receive an interrupt after entering WFI but before the PMU has
>     suspended the system, causing suspend to fail.
>
>     BUG=chrome-os-partner:20523
>     TEST=Run suspend_stress_test on Pit and observe that entering suspend
>     no longer occasionally fails with the "Failed to suspend the system"
>     error in exynos_cpu_suspend().
>
>     Change-Id: Ia2d963191f4e5485beb295b28f128f2ce256f987
>     Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>     Reviewed-on: https://gerrit.chromium.org/gerrit/61948
>     Reviewed-by: Simon Glass <sjg@chromium.org>
>

Regards,
Abhilash
_______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
