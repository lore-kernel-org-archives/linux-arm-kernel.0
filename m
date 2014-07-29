From: balbi@ti.com (Felipe Balbi)
Date: Tue, 29 Jul 2014 10:40:57 -0500
Subject: [PATCH 29/35] arm: omap: intc: switch over to linear irq domain
In-Reply-To: <20140729152052.GV29045@atomide.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <1406582183-696-30-git-send-email-balbi@ti.com>
 <20140729121425.GR29045@atomide.com>
 <20140729141522.GB17808@saruman.home>
 <20140729152052.GV29045@atomide.com>
Message-ID: <20140729154057.GE17808@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 08:20:52AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [140729 07:18]:
> > Hi,
> > 
> > On Tue, Jul 29, 2014 at 05:14:25AM -0700, Tony Lindgren wrote:
> > > * Felipe Balbi <balbi@ti.com> [140728 14:19]:
> > > > now that we don't need to support legacy board-files,
> > > > we can completely switch over to a linear irq domain
> > > > and make use of irq_alloc_domain_generic_chips() to
> > > > allocate all generic irq chips for us.
> > > 
> > > This patch seems to somehow break off-idle for omap3 
> > > where it no longer wakes up.
> > 
> > Sure your bisection is correct ? This patch just switches from legacy
> > irq domain to linear irq domain.
> 
> Yes, I tried it a few times. Just enabling
> retention idle hangs too with this patch.
> 
> Maybe it's omap3_prcm_irq_setup that relies on
> 11 + OMAP_INTC_START? There may be other such issues

lol.

OMAP4 has the same nonsense.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/e8707058/attachment.sig>
