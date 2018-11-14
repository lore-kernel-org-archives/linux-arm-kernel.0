From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Wed, 14 Nov 2018 23:33:52 +0100
Subject: [PATCH 0/2] clocksource/meson6_timer: implement ARM delay timer
In-Reply-To: <20181028125501.17336-1-martin.blumenstingl@googlemail.com>
References: <20181028125501.17336-1-martin.blumenstingl@googlemail.com>
Message-ID: <CAFBinCDUYwDn8e4wOKzRCeKMgE0Ey8e_RhmPKim60sbrHBq_Xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel, Hi Thomas,

On Sun, Oct 28, 2018 at 1:55 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> While trying to add support for the ARM TWD Timer and the ARM Global
> Timer on Meson8, Meson8b and Meson8m2 (ARM Cortex-A5 and Cortex-A9 SoCs)
> I did a review of the existing driver.
> Unfortunately I found it hard to review because the pre-processor
> #defines did not match the names from the public S805 datasheet. Thus
> patch #1 adjusts these. No functional changes here, this is just
> preparation work for patch #2.
>
> Using the ARM Global Timer (drivers/clocksource/arm_global_timer.c)
> would have given us a timer-based delay implementation (so udelay() and
> friends would use the timer instead of using a loop-based delay
> implementation). Unfortunately we can't use the ARM Global Timer yet
> because it's input clock is derived from the CPU clock (which can change
> once we enable CPU frequency scaling on these SoCs, for which I will be
> sending patches in the near future).
> Amlogic's 3.10 kernel uses Timer E as delay timer which (with the
> current configuration) has a resolution of 1us. So patch #2 uses
> register_current_timer_delay() to register Timer E as ARM delay timer
> (which will be especially useful as we have to use udelay() when
> changing the CPU clocks during DVFS).
>
>
> Martin Blumenstingl (2):
>   clocksource: meson6_timer: use register names from the datasheet
>   clocksource: meson6_timer: implement ARM delay timer
(gentle ping) can you please queue these two patches for v4.21?
if not: please let me know what I can improve, then I'll fix that and send a v2


thank you!
Regards
Martin
