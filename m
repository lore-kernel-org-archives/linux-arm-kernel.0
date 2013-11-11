From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 11 Nov 2013 17:55:02 +0100
Subject: [PATCH] ARM: signal: fix armv7-m build issue in sigreturn_codes.S
In-Reply-To: <20131111093311.GK14892@pengutronix.de>
References: <1384157427-31613-1-git-send-email-victor.kamensky@linaro.org>
 <20131111093311.GK14892@pengutronix.de>
Message-ID: <20131111165502.GL14892@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Victor,

On Mon, Nov 11, 2013 at 10:33:11AM +0100, Uwe Kleine-K?nig wrote:
> On Mon, Nov 11, 2013 at 12:10:26AM -0800, Victor Kamensky wrote:
> > Here is proposal for armv7-m build failure in sigreturn_codes.S. The 
> > armv7-m build issue was discussed in [1].
> > 
> > Proposed solution is based on conditional compilation. If 
> > CONFIG_CPU_THUMBONLY is set instead of arm opcodes nops in thumb mode
> > are used. I've tried to wrap conditional compilation as nice as I 
> > found possible. Other suggestions/approaches are welcome.
> > 
> > Fix was tested:
> >    linux-next with efm32_defconfig build (along with few other fixes)
> >    rmk-next BE/LE arndale build/boot and LTP rt_sigaction0? tests run
> Next currently fails for other reasons, too and I'm out of time. I'd say
> if it compiles for you it's fine and I will handle eventual fall-outs
> later.
next-20131111 + your patch + reverts of d779c07dd7209 and 50e05119f9800
compiles and boots fine.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
