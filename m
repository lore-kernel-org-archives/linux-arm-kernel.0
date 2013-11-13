From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 13 Nov 2013 14:39:52 +0100
Subject: [PATCH 1/2] ARM: default PHYS_OFFSET if !MMU
In-Reply-To: <528366A9.7060504@arm.com>
References: <1384341351-4110-1-git-send-email-tom.leiming@gmail.com>
 <1384341351-4110-2-git-send-email-tom.leiming@gmail.com>
 <528366A9.7060504@arm.com>
Message-ID: <20131113133952.GW14892@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 13, 2013 at 11:46:49AM +0000, Jonathan Austin wrote:
> Hi Ming,
> 
> On 13/11/13 11:15, Ming Lei wrote:
> > From: Jonathan Austin <jonathan.austin@arm.com>
> > 
> > Set CONFIG_PAGE_OFFSET as PHYS_OFFSET when !MMU so that
> > we can keep CONFIG_PAGE_OFFSET same with PAGE_OFFSET.
> >
> 
> I'm not so sure about this commit message - I don't think
> it makes sense...Should it not be more like:
> 
> ------->8-------
> Subject: ARM: set PAGE_OFFSET = PHYS_OFFSET if !MMU
> 
> With !MMU we still set PAGE_OFFSET to 0xC0000000, which
> makes little sense and causes a regression on !MMU after
> f6537f2f0eba4eba ("scripts/kallsyms: filter symbols not
> kernel address space")
> 
> This patch sets PAGE_OFFSET to PHYS_OFFSET in the !MMU
> case, fixing the regression (Tested on Cortex-R7/Vexpress)
> --------8<---------
I like this commit log better, too.

As CONFIG_PAGE_OFFSET is only used in scripts/kallsyms.c and
scripts/link-vmlinux.sh for !MMU.

Booting on efm32 with this patch works just fine, so if you want add my
Tested-by. But I'm unsure how valuable it is as I don't see a breakage
without it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
