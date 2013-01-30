From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 30 Jan 2013 14:10:44 +0100
Subject: [PATCH] ARM i.MX25: clk: parent per5_clk to AHB clock
In-Reply-To: <20130130095353.GI8668@pengutronix.de>
References: <1359538435-21304-1-git-send-email-s.trumtrar@pengutronix.de>
 <20130130095353.GI8668@pengutronix.de>
Message-ID: <20130130131044.GA20392@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 10:53:53AM +0100, Uwe Kleine-K?nig wrote:
> On Wed, Jan 30, 2013 at 10:33:55AM +0100, Steffen Trumtrar wrote:
> > The mxc-timer on the imx25 needs to be derived from the AHB clock.
> > If a bootloader reparents this clock to the ipg_clk_highfreq, which according
> > to the datasheet is a valid operation, the system can/will produce lockups/
> > freezes after some time [1].
> > 
> > This can be forced with code like
> > 	while(1)
> >                 syscall(SYS_clock_gettime, CLOCK_REALTIME, &tp);
> > 
> > This was already fixed with the commit
> > 	 "i.MX25 GPT clock fix: ensure correct the clock source" [2],
> > but it seems, that it got lost. So, re-add this to have a correct gpt.
> > 
> > [1]: http://lists.arm.linux.org.uk/lurker/message/20130129.161230.229bda17.en.html
> > [2]: 2012d9ca2a1381ae3e733330a7f0d1d2f1988bba
> Instead of the last paragraph I'd write:
> 
> 	This problem was already fixed with commit
> 
> 		2012d9c (i.MX25 GPT clock fix: ensure correct the clock source)
> 
> 	for v3.1-rc2 but this was lost when i.MX was converted to the common
> 	clock framework (commit 6bbaec5; ARM i.MX25: implement clocks using
> 	common clock framework).
> 
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > Cc: stable at vger.kernel.org
> 
> Cc: stable at vger.kernel.org # v3.5+
> 

That is better. I will resend my patch in a sec with a new commit message.

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
