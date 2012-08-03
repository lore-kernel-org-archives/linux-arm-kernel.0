From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 3 Aug 2012 16:50:35 +0200
Subject: [PATCH v6 0/3] Updated Cortex-M3 series
In-Reply-To: <201208031407.09092.arnd@arndb.de>
References: <1343988614-5508-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201208031407.09092.arnd@arndb.de>
Message-ID: <20120803145035.GJ2626@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Aug 03, 2012 at 02:07:08PM +0000, Arnd Bergmann wrote:
> On Friday 03 August 2012, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > the only changes compared to v5 (sent starting with Message-id:
> > 1341512035-8173-1-git-send-email-u.kleine-koenig at pengutronix.de)
> > are that several debug pr_infos were dropped that I missed to remove
> > before. Thanks to Will Deacon for pointing out that problem.
> > Furthermore I rebased (trivially) to v3.5.
> 
> No objections to the code from my side, but I'd like to understand
> the big picture here. You introduce a new CPU_V7M configuration
> symbol in the code, but there is no Kconfig change that introduces
> that symbol. Is that another change that is still coming?
I need to rework irq support which is up to now a seperate driver (nvic)
but it should be possible to integrate it into the gic driver. With this
patch I intend to send the Kconfig and Makefile stuff to make the code
actually do something.

> None of the code seems to be specific to Cortex-M3 rather than the
> ARMv7M architecture. Does that mean it is expected to run
> unmodifed on both M3 and M4, and possibly future ARMv-7M cores?
I'd expect to have M4 working out of the box. But as I don't have an M4
I cannot tell for sure.
 
> Is it possible to build a NOMMU kernel that runs on both ARMv7-A
> amd ARMv7-M, in other words is ARMv7-M compatible with ARMv7-A
> (or ARMv7-R for that matter) if you don't use the MMU?
the instructions to enable and disable irqs are different, so we'd need
another indirection at least there. Also the whole exception model is
different. So I'd say it's too different to target for a common kernel
for the A, R and M profiles.
 
> How does this relate to the ARMv6-M (Cortex-M0/M0+/M1) support
> that has been floating around [1]? Can we support both in
> the same kernel? 
I don't know M0/M1 but from a quick look at the tree you pointed out I'd
say they look reasonably similar.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
