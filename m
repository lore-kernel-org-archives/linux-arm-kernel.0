From: mcdonald.shane@gmail.com (Shane McDonald)
Date: Sun, 18 Oct 2009 23:17:47 -0600
Subject: [PATCH] Make MIPS dynamic clocksource/clockevent clock code
	generic
In-Reply-To: <1255819715-19763-1-git-send-email-linus.walleij@stericsson.com>
References: <1255819715-19763-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <b2b2f2320910182217m31ce0a96g4912eeb9bea5f817@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello:

On Sat, Oct 17, 2009 at 4:48 PM, Linus Walleij <linus.walleij@stericsson.com
> wrote:

> This moves the clocksource_set_clock() and clockevent_set_clock()
> from the MIPS timer code into clockchips and clocksource where
> it belongs. The patch was triggered by code posted by Mikael
> Pettersson duplicating this code for the IOP ARM system. The
> function signatures where altered slightly to fit into their
> destination header files, unsigned int changed to u32 and inlined.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mikael Pettersson <mikpe@it.uu.se>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
> Ralf has stated in earlier conversation that this should be moved,
> now we risk duplicating code so let's move it.
>
> I don't have access to a MIPS cross-compiler so please can the
> MIPS people test this?
>

I have tested this patch on an RM7000-based MIPS system.  The patch compiles
fine, and the kernel successfully runs.  You can add my:

Tested-by: Shane McDonald <mcdonald.shane@gmail.com>

Shane
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091018/2637ae75/attachment.htm>
