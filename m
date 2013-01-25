From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 25 Jan 2013 09:25:28 +0000
Subject: [PATCH 4/4] irqchip: gic: Perform the gic_secondary_init()
 call via CPU notifier
In-Reply-To: <20130125043039.GN13691@verge.net.au>
References: <1358963974-5496-1-git-send-email-catalin.marinas@arm.com>
 <1358963974-5496-5-git-send-email-catalin.marinas@arm.com>
 <20130125043039.GN13691@verge.net.au>
Message-ID: <20130125092527.GA6619@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 04:30:39AM +0000, Simon Horman wrote:
> On Wed, Jan 23, 2013 at 05:59:34PM +0000, Catalin Marinas wrote:
> > All the calls to gic_secondary_init() pass 0 as the first argument.
> > Since this function is called on each CPU when starting, it can be done
> > in a platform-independent way via a CPU notifier registered by the GIC
> > code.
> >
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Kukjin Kim <kgene.kim@samsung.com>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: David Brown <davidb@codeaurora.org>
> > Cc: Daniel Walker <dwalker@fifo99.com>
> > Cc: Bryan Huntsman <bryanh@codeaurora.org>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: Dinh Nguyen <dinguyen@altera.com>
> > Cc: Viresh Kumar <viresh.linux@gmail.com>
> > Cc: Shiraz Hashim <shiraz.hashim@st.com>
> > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> 
> mach-shmobile portion:
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
> For the record, I tested this on the kzm9g, kzm9d and marzen boards
> which use the r8a7779, EMEV2 and r8a7779 SoCs respectively.

Thanks. Can I add a Tested-by as well?

-- 
Catalin
