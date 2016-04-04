From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 4 Apr 2016 13:21:00 +0200
Subject: [PATCH v2 02/16] arm64: dts: add sp804 timer node for Hi6220
In-Reply-To: <20160404014359.GA15178@leoy-linaro>
References: <1459589383-16914-1-git-send-email-guodong.xu@linaro.org>
 <1459589383-16914-3-git-send-email-guodong.xu@linaro.org>
 <CACRpkdbWuKx6=aF5xW=3EKfuUf-MYM_EEnovyhBnOGVOeHyCmQ@mail.gmail.com>
 <20160404014359.GA15178@leoy-linaro>
Message-ID: <CACRpkdZ=_86Rhc+ei+3uE0dda9+onC8pQwosheMfEj4tOqmcDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 4, 2016 at 3:43 AM, Leo Yan <leo.yan@linaro.org> wrote:
> On Sun, Apr 03, 2016 at 09:23:42PM +0200, Linus Walleij wrote:
>> On Sat, Apr 2, 2016 at 11:29 AM, Guodong Xu <guodong.xu@linaro.org> wrote:

>> By chance the code in the driver will allow just one clock and
>> will then assume that both the bus to the timer and the timer
>> itself is clocked from the same clock. But I highly doubt that this
>> is the case.
>
> This patch has been sent out for review previously [1]; So I refered
> other platforms and changed to only enable apb bus clock due I have
> not found timer enabling bits in Hi6220's spec.

This is not about enabling/disabling the clock(s) to the timer.
It doesn't matter if these clocks are always on.

It is about determining the *frequency* of the timers.

It is vital that the timer driver get the right frequency of the clock
to the block from the clock implementation, and I do not think
it is the same as the "apb_pclk".

The thing is that of course "any frequency" will
work but what you will notice is that the timer runs very
weirdly compared to wall-clock time unless the right clock
yielding the right frequency has been specified here.

Yours,
Linus Walleij
