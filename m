From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Sep 2011 11:23:57 +0200
Subject: [PATCH 3/4] mach-integrator: modernize clock event registration
In-Reply-To: <20110908085502.GB14953@n2100.arm.linux.org.uk>
References: <1315384260-27404-1-git-send-email-linus.walleij@stericsson.com>
	<alpine.LFD.2.02.1109071202000.2723@ionos>
	<20110908085502.GB14953@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZ0HgvhgFU9-4f7QtWT3aJuZhY8QQB+oEW0mEy+Uzuh=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2011 at 10:55 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> Acked-by: Thomas Gleixner <tglx@linutronix.de>

> My understanding is that periodic timers are not setup by the generic
> clock event code, and so we do need to keep the 'timer_reload' stuff
> around.

Aha. Yes maybe I've not tested that mode well enough, I'll
have a closer look.

An alteranative is to retire the periodic mode and only
support oneshot, like the plat-nomadik/timer.c currently
does. My impression is that oneshot will always work fine,
and doing this leaves all details up to the timekeeping
core so we don't need to deal with it, but I may be wrong.
Ideas?

> Note that patch 2 deletes the register write for this too,
> so you actually have one logical change split across patch 2 and 3.

Yes, no good. I'll fix.

Yours,
Linus Walleij
