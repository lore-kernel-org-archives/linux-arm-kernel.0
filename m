From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 2 Jan 2012 13:59:10 +0100
Subject: snowball does not compile on linux-next
In-Reply-To: <4F0199CF.2070806@linaro.org>
References: <4F0199CF.2070806@linaro.org>
Message-ID: <CACRpkdbn6H_s8oC3VdqH2CoCZcPkc+hYccLE1UQJZnqB5eSf3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 2, 2012 at 12:49 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> the kernel does not compile when
> CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK is set.
>
> it fails with :
>
> ?CHK ? ? include/linux/version.h
> ?CHK ? ? include/generated/utsrelease.h
> make[1]: `include/generated/mach-types.h' is up to date.
> ?CALL ? ?scripts/checksyscalls.sh
> ?CHK ? ? include/generated/compile.h
> ?CC ? ? ?drivers/clocksource/clksrc-dbx500-prcmu.o
> drivers/clocksource/clksrc-dbx500-prcmu.c:61: warning: type defaults
> to ?int? in declaration of ?DEFINE_CLOCK_DATA?
> drivers/clocksource/clksrc-dbx500-prcmu.c:61: warning: parameter names
> (without types) in function declaration
> drivers/clocksource/clksrc-dbx500-prcmu.c: In function ?sched_clock?:
> drivers/clocksource/clksrc-dbx500-prcmu.c:72: error: implicit
> declaration of function ?cyc_to_sched_clock?
> drivers/clocksource/clksrc-dbx500-prcmu.c:72: error: ?cd? undeclared
> (first use in this function)
> drivers/clocksource/clksrc-dbx500-prcmu.c:72: error: (Each undeclared
> identifier is reported only once
> drivers/clocksource/clksrc-dbx500-prcmu.c:72: error: for each function
> it appears in.)
> drivers/clocksource/clksrc-dbx500-prcmu.c: In function
> ?clksrc_dbx500_prcmu_update_sched_clock?:
> drivers/clocksource/clksrc-dbx500-prcmu.c:78: error: implicit
> declaration of function ?update_sched_clock?
> drivers/clocksource/clksrc-dbx500-prcmu.c:78: error: ?cd? undeclared
> (first use in this function)
> drivers/clocksource/clksrc-dbx500-prcmu.c: In function
> ?clksrc_dbx500_prcmu_init?:
> drivers/clocksource/clksrc-dbx500-prcmu.c:100: error: implicit
> declaration of function ?init_sched_clock?
> drivers/clocksource/clksrc-dbx500-prcmu.c:100: error: ?cd? undeclared
> (first use in this function)
> make[2]: *** [drivers/clocksource/clksrc-dbx500-prcmu.o] Error 1
> make[1]: *** [drivers/clocksource] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [drivers] Error 2
> make: *** Waiting for unfinished jobs....
>
> Is it dead code ?

No if it was dead it shouldn't get compiled.

It' probably just some fallout from Marc's rewrite of the
sched_clock() stuff, I'll see if I can cook a patch and
send off to Marc.

Yours,
Linus Walleij
