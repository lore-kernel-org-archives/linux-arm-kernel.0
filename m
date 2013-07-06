From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 6 Jul 2013 23:00:30 +0200 (CEST)
Subject: [PATCH 9/9] clocksource: dw_apb_timer: special variant for
 rockchip rk3188 timers
In-Reply-To: <51D87E04.3060704@googlemail.com>
References: <201307060051.09716.heiko@sntech.de>
 <201307060056.29370.heiko@sntech.de>
 <alpine.DEB.2.02.1307060153110.32106@ionos.tec.linutronix.de>
 <51D87E04.3060704@googlemail.com>
Message-ID: <alpine.DEB.2.02.1307062233480.32106@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulrich,

On Sat, 6 Jul 2013, Ulrich Prinz wrote:

> I got the message. With modifying the existing driver to support more
> function pointers in its system struct and assigning them at the
> beginning, and using them on runtime, these quirks are obsolete.

Correct.
 
> Again, this is the first time I provide code to the kernel officially

No problem. That's what code review is about. First post or not.

> and I learned from others that I should try it by modifying not too much
> code if not needed.
> 
> Adding more function pointers to a system relevant structure, doubling
> the number of functions and such didn't look non-invasive to me.

Well, it always depends. If there is a single place to deal with some
oddball hardware, a flag is often the simplest way to go.

If you have to add 10 conditionals in several functions then in a
first step converting the existing implementation into function
pointer calls and then in the next step providing new implementations
for your hardware is most of the time simpler and cleaner.

> But, I totally agree with your argumentation and I even wanted to do it
> in the way you explained in your replies. Just the courage was missing I
> guess :)

Gut feelings are often a better guidance than our self-doubting
intellect. :)

But don't worry. I had to learn it the hard way as well and I still
trip over from time to time.

Thanks,

	tglx
