From: balbi@ti.com (Felipe Balbi)
Date: Tue, 29 Jul 2014 09:15:22 -0500
Subject: [PATCH 29/35] arm: omap: intc: switch over to linear irq domain
In-Reply-To: <20140729121425.GR29045@atomide.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <1406582183-696-30-git-send-email-balbi@ti.com>
 <20140729121425.GR29045@atomide.com>
Message-ID: <20140729141522.GB17808@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 29, 2014 at 05:14:25AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [140728 14:19]:
> > now that we don't need to support legacy board-files,
> > we can completely switch over to a linear irq domain
> > and make use of irq_alloc_domain_generic_chips() to
> > allocate all generic irq chips for us.
> 
> This patch seems to somehow break off-idle for omap3 
> where it no longer wakes up.

Sure your bisection is correct ? This patch just switches from legacy
irq domain to linear irq domain.

> Other than that, this whole series boots fine for me.

good

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/536d4ba2/attachment.sig>
