From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Dec 2011 12:31:03 +0100
Subject: [PATCH 2/4] ARM: smp_twd: create a percpu reference to the
 clockevent
In-Reply-To: <20111212134904.GV14542@n2100.arm.linux.org.uk>
References: <1323683830-23867-1-git-send-email-linus.walleij@stericsson.com>
 <20111212134904.GV14542@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYEitq9a7ZPMP-pHP7NtRPZTbmzJmayFDBA210rkwZaKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 2:49 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Dec 12, 2011 at 10:57:10AM +0100, Linus Walleij wrote:
>> ?static unsigned long twd_timer_rate;
>> +static DEFINE_PER_CPU(struct clock_event_device *, twd_ce);
>>
>> ?static struct clock_event_device __percpu **twd_evt;
>
> So, one pointer to the clock_event_device is not enough? ?Could we have
> one or the other?

Bah, just me being lame and not seeing that Marc already made
these events per-cpu.

I'll update the CPUfreq patch and drop this crap.

Thanks,
Linus Walleij
