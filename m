From: k.chander@samsung.com (Chander Kashyap)
Date: Wed, 11 Jun 2014 10:22:10 +0530
Subject: [PATCH] ARM: EXYNOS: mcpm: Don't rely on firmware's
 secondary_cpu_start
In-Reply-To: <alpine.LFD.2.11.1406101146140.25775@knanqh.ubzr>
References: <1402090985-8061-1-git-send-email-dianders@chromium.org>
 <20140607181221.GB25068@e102568-lin.cambridge.arm.com>
 <CAD=FV=X17PeJ6JPE9Qyc1QT07AvA2PTE69Q87gz9a6MdUHgi4A@mail.gmail.com>
 <20140609223831.GB16889@e102568-lin.cambridge.arm.com>
 <CANuQgHHxAhTNYX-JAEdRkO=PMYT4A5GwXcuQfiqwE0CEkQyR+w@mail.gmail.com>
 <CAD=FV=V5_RRNkgA7Rk7XbQw9m1qh6-RJA8arW7ZRU=QbWAPa+w@mail.gmail.com>
 <alpine.LFD.2.11.1406101146140.25775@knanqh.ubzr>
Message-ID: <CADWw7OjqK3MAuqCHuv-WS3Bb2+2Q-FXth+7hqtwFoyAP6pyYhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On Tue, Jun 10, 2014 at 9:19 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 10 Jun 2014, Doug Anderson wrote:
>
>> My S-state knowledge is not strong, but I believe that Lorenzo's
>> questions matter if we're using S2 for CPUidle (where we actually turn
>> off power and hot unplug CPUs) but not when we're using S1 for CPUidle
>> (where we just enter WFI/WFE).
>>

No Its not plain WFI.

All cores in Exynos5420 can be powered off independently.
This functionality has been tested.

Below is the link for the posted patches.

https://lkml.org/lkml/2014/6/10/194

And as Nicolas wrote, these patches need MCPM for that.

>> I believe that in ChromeOS we use S1 CPUidle and that it works fine.
>> We've never implemented S2 that I'm aware of.
>
> You'll have to rely on MCPM for that.  That's probably why it hasn't
> been implemented before.
>
>
> Nicolas
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
