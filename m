From: srinidhi.kasagar@stericsson.com (Srinidhi KASAGAR)
Date: Wed, 16 Feb 2011 11:33:55 +0530
Subject: [PATCH] ARM: errata: pl310 cache sync operation may be faulty
In-Reply-To: <20110215113422.GE4152@n2100.arm.linux.org.uk>
References: <1297768683-30273-1-git-send-email-srinidhi.kasagar@stericsson.com>
	<20110215113422.GE4152@n2100.arm.linux.org.uk>
Message-ID: <20110216060351.GB16604@bnru02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 12:34:22 +0100, Russell King - ARM Linux wrote:
> On Tue, Feb 15, 2011 at 04:48:03PM +0530, srinidhi kasagar wrote:
> > +#ifdef ARM_ERRATA_753970
> > +#define L2X0_DUMMY_REG  0x740
> > +	/* write to an unmmapped register */
> > +	writel_relaxed(0, base + L2X0_DUMMY_REG);
> > +	cache_wait(base + L2X0_CACHE_SYNC, 1);
> > +#else
> >  	writel_relaxed(0, base + L2X0_CACHE_SYNC);
> >  	cache_wait(base + L2X0_CACHE_SYNC, 1);
> > +#endif
> 
> So why wrap cache_wait() up in that horrible ifdef as well - and why not
> put the dummy register definition along side the other register definitions?

updated patch below
