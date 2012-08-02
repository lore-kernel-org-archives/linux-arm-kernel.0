From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 2 Aug 2012 09:15:30 +0200
Subject: How to debug hard lockup issue
In-Reply-To: <CAF1ivSY=HsqrRypru55cYMBoyY75umkwrjbz5U0F85nL5mh3tw@mail.gmail.com>
References: <CAF1ivSY=HsqrRypru55cYMBoyY75umkwrjbz5U0F85nL5mh3tw@mail.gmail.com>
Message-ID: <20120802071530.GG10670@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Aug 02, 2012 at 11:03:31AM +0800, Lin Ming wrote:
> I encountered a hard lockup on a armv5 board with 2.6.32 kernel.
> There is no any message output since it is hard lockup.
> 
> I tried watchdog, but watchdog can only reset the board. I still can't
> get any info.
> 
> The hard lockup is possibly because kernel blocked/looped with
> interrupts disabled.
> 
> Is there any non-maskable interrupt I can use to dump the kernel stack?
> Or any other hint?
Try enabling various debug options. The following come to (my) mind:

CONFIG_DETECT_HUNG_TASK
CONFIG_PROVE_LOCKING
CONFIG_DEBUG_ATOMIC_SLEEP
CONFIG_MAGIC_SYSRQ

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
