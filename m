From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 15 Feb 2017 14:06:03 -0300
Subject: [PATCH] clk: rockchip: Set "ignore unused" for PMU M0 clocks on
 rk3399
In-Reply-To: <1716357.fXUCSFMPB6@diego>
References: <20170214210114.5846-1-dianders@chromium.org>
 <CABxcv=kzW9SvrWYNasqCDkV7D6Y2zq+oRuqoPFdWuaWUhPehEA@mail.gmail.com>
 <1716357.fXUCSFMPB6@diego>
Message-ID: <CABxcv=m8X1o=5vo1CdpozD2YgfVZUq663+etc-ywGwBPvSs1Qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Heiko and Doug,

On Wed, Feb 15, 2017 at 2:01 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Am Mittwoch, 15. Februar 2017, 12:27:59 CET schrieb Javier Martinez Canillas:
>> Hello Doug,
>>
>> On Tue, Feb 14, 2017 at 6:01 PM, Douglas Anderson <dianders@chromium.org>
> wrote:
>> > The PMU Cortex M0 on rk3399 is intended to be used for things like
>> > DDRFreq transitions, suspend/resume, and other things that are the
>> > purview of ARM Trusted Firmware and not the kernel.  As such, the
>> > kernel shouldn't be messing with the clocks.  Add CLK_IGNORE_UNUSED to
>> > these clocks.
>>
>> Isn't CLK_IS_CRITICAL a more suitable flag for this case?
>
> From the patch description it looks like the clock is expected to be
> controlled from firmware in most cases as I guess the Cortex M0 will be used
> for that all the time now. And the clock is not expected to run all the time.
>
> So I'd think clk_ignore_unused is the correct one. The whole clock-subtree for
> these clocks also does not get affected by other clocks, as it is
> independendly coming from PLLs.
>
>

I see. Thanks a lot for your explanations. I just asked because
CLK_IGNORE_UNUSED only prevents the clock to be disabled by
clk_disable_unused() but still can be disabled if a driver explicitly
looks it up and calls clk_disable() or if the clock is affected by
other clocks.

But I understand now that both scenarios are not possible. So yes,
CLK_IGNORE_UNUSED is more suitable in this case.

> Heiko

Best regards,
Javier
