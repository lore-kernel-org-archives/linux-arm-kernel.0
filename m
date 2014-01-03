From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Fri, 03 Jan 2014 07:01:46 +0100
Subject: v3.13-rc6+ regression (ARM board)
In-Reply-To: <CA+55aFyZ0EXYkHd-BhQo6K++qKJVPdGeDbFTVTs3pAPCHFUpOA@mail.gmail.com>
 (Linus Torvalds's message of "Thu, 2 Jan 2014 11:38:56 -0800")
References: <m3mwjhux0e.fsf@t19.piap.pl> <20131231104511.GA9688@1wt.eu>
 <m3txdmu2ez.fsf@t19.piap.pl> <20140102101455.GG10158@pengutronix.de>
 <m3ppoatwn1.fsf@t19.piap.pl>
 <CA+55aFyZ0EXYkHd-BhQo6K++qKJVPdGeDbFTVTs3pAPCHFUpOA@mail.gmail.com>
Message-ID: <m3k3ehtxh1.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

>   --- a/kernel/time/sched_clock.c
>   +++ b/kernel/time/sched_clock.c
>   @@ -36,6 +36,7 @@ core_param(irqtime, irqtime, int, 0400);
>
>    static struct clock_data cd = {
>           .mult   = NSEC_PER_SEC / HZ,
>   +       .seq = SEQCNT_ZERO(cd.seq),
>    };
>
>    static u64 __read_mostly sched_clock_mask;

Same here, problem still exists (tested with lockdep).
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
