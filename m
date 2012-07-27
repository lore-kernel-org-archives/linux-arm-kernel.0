From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 28 Jul 2012 00:42:06 +0200
Subject: [PATCH 1/8] ARM: support for Moschip MCS814x SoCs
In-Reply-To: <6220407.M8CZZfZu0N@bender>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
 <1342363754-30808-2-git-send-email-florian@openwrt.org>
 <20120716142941.666d928c@skate> <6220407.M8CZZfZu0N@bender>
Message-ID: <CACRpkdah3B95C0f7C78E65mWWc7+5VE__ByFQ+vFBv6BA=LKRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 9:11 PM, Florian Fainelli <florian@openwrt.org> wrote:

> [Thomas P]
>> I am surprised that this doesn't use the clocksource and clockevents
>> infrastructure. It probably should, and be implemented in
>> drivers/clocksource/.
>
> This may sound like a stupid question, but the big constraint with this SoC is
> that the timers do not reload themselves, and so far, I did not find out how I
> can handle this properly with a clocksource. I suppose that it should not be a
> big problem for the clockevent device however.
>
> Has anyone any example of such particular case?

Gah what horror.

So you don't have *anything* in your platform which is really
continous and sufficiently fast?

Then try to get an IRQ to rearm and retrigger the timer to fire
itself whenever it reloads and pray this doesn't add a skew too much.
Bonus if you can use the NMI for this :-/

Yours,
Linus Walleij
