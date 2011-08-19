From: davidb@codeaurora.org (David Brown)
Date: Fri, 19 Aug 2011 14:19:02 -0700
Subject: of_iomap() matched with plan iounmap()
In-Reply-To: <201108191426.19152.arnd@arndb.de>
References: <20110818170226.GA16721@huya.qualcomm.com>
	<20110818.203447.462383652600224162.davem@davemloft.net>
	<201108191426.19152.arnd@arndb.de>
Message-ID: <20110819211902.GA19702@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2011 at 02:26:18PM +0200, Arnd Bergmann wrote:
> On Friday 19 August 2011, David Miller wrote:
> > From: David Brown <davidb@codeaurora.org>
> > Date: Thu, 18 Aug 2011 10:02:26 -0700
> > 
> > > The SPARC target contains of_ioremap() and of_iounmap(), which various
> > > drivers use (generally inside of CONFIG_SBUS).
> > > 
> > > include/linux/of_address.h contains a definition for of_iomap(), but
> > > not corresponding unmap call.  Code using this calls the regular
> > > iounmap().
> > > 
> > > Is it safe to assume that of_iomap() will always be based on ioremap()
> > > and therefore it is safe to use iounmap(), or would it be better to
> > > define another name for drivers to use as the inverse of of_iomap().
> > > I'm not sure what to call it, since of_iounmap() is already taken by
> > > SPARC.
> > 
> > It's better to define a matching of_iounmap() interface, even if for
> > now it is exactly iounmap()
> 
> But the problem is that we need conflicting prototypes for of_iounmap.

What if we left the SPARC calls alone, and changed of_iomap() into
of_dt_iomap() and could then make of_dt_iounmap().  Or, it could just
be of_dt_map(), and of_dt_unmap().

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
