From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 24 Jun 2014 11:02:01 +0200
Subject: [PATCH V2 0/2] Sound support for Exynos4412 Odroid X2, U3 board
In-Reply-To: <CAD8Lp46gqbV9gDfrH2hbVnF7s6wK6ASBdsX7vn0L0CFAHXSemg@mail.gmail.com>
References: <1403108551-25058-1-git-send-email-s.nawrocki@samsung.com>
 <CAD8Lp44h6zc2Rt2MGLjhmNG-YB0kYCWf5G7hX5JmdmBfc1PvKg@mail.gmail.com>
 <53A856AE.1030202@samsung.com>
 <CAD8Lp46gqbV9gDfrH2hbVnF7s6wK6ASBdsX7vn0L0CFAHXSemg@mail.gmail.com>
Message-ID: <53A93E89.2030901@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-06-24 10:35, Daniel Drake wrote:
> On Mon, Jun 23, 2014 at 5:32 PM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> I could reproduce such behaviour on the U3 board, but only with u-boot
>> which sets the MPLL clock frequency (fout_mpll) to 880 MHz, rather
>> than 800 MHz, which was the case in my original environment.
>> All fout_mpll child clocks have then different frequency values
>> in both cases.
>> It's a bit strange though, because frequencies of all the audio
>> subsystem clocks seem to be same anyway:
> I'm using the standard uboot from hardkernel.
>
>> # cat /sys/kernel/debug/clk/clk_summary
> This command makes the kernel totally hang, weird.

This is known issue with clocks vs. ISP power domain. We should really 
fix this in exynos4 clock driver.

> # speaker-test -c 2 -t wav -l 2 -p 1024
>
> This plays back fine.
>
> Could it be a problem with the samsung-i2s driver, not correctly
> flushing at the right times?
> Or do you think the problem is more likely to be clock-related?

Hard to say right now, but at least we need to test a bit more our 
solutions with different initial clocks configuration.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
