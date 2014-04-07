From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Apr 2014 09:28:39 -0700
Subject: [PATCH V2 17/17] ARM: exynos: config: Enable cpuidle
In-Reply-To: <5825506.2ErDt1UQ5r@amdc1032>
References: <1396618989-2897-1-git-send-email-daniel.lezcano@linaro.org>
 <1396618989-2897-18-git-send-email-daniel.lezcano@linaro.org>
 <5825506.2ErDt1UQ5r@amdc1032>
Message-ID: <CAOesGMgkbfUX=cJ4rMf+-26Sq_fYUNW8m6unNiCXHKwj83dLbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 4, 2014 at 9:09 AM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:

[...]
>   I know that this is mainly our problem but the issue is widespread on
>   our targets and I believe that adding some workaround for it in cpuidle
>   core would be beneficial for the whole cpuidle subsystem.

Yes, we need to find a way forward without you guys holding the whole
platform hostage with out-of-tree code (here and in general, since I
think there are more areas in which this applies).

>  Namely there
>   should be some way of telling cpuidle subsystem to either disable
>   particular state(s) or limit the max available state.  I think that this
>   can be also useful for testing and development of other cpuidle drivers.
>
> For now please change this patch to add CONFIG_CPU_IDLE=n instead (since
> the config option is "default y" it will be auto-enabled if there is no
> entry in the defconfig)..

Can the code be refactored such that even if CPU_IDLE is on, it won't
actually do anything useful on the platforms that have problems above?
I.e. determined at runtime, not build time?


(I have not yet looked at the rest of the series).


-Olof
