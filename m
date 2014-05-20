From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Tue, 20 May 2014 16:40:03 +0200
Subject: [PATCH v4 1/7] phy: add a driver for the Berlin SATA PHY
In-Reply-To: <20140520140631.GF9873@lunn.ch>
References: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
 <1400576675-25265-2-git-send-email-antoine.tenart@free-electrons.com>
 <1821771.zFvTDGF2Ae@amdc1032> <20140520134942.GC9873@lunn.ch>
 <20140520140325.GA21579@kwain> <20140520140631.GF9873@lunn.ch>
Message-ID: <20140520144003.GD21579@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 04:06:31PM +0200, Andrew Lunn wrote:
> > > > > +config PHY_BERLIN_SATA
> > > > > +	bool
> > > > 
> > > > Is there any real reason why this cannot be tristate?
> > > 
> > > What we have seen with SATA drivers and phys, is there is link time
> > > breakage if the SATA driver is built in and the phy is modular.
> > > 
> > > Maybe this has been fixed now? 
> > 
> > Using tristate shouldn't be a problem. I compiled without the PHY
> > driver, no link issue.
> 
> The problem i think was when the PHY core and driver was a module and
> SATA built in. Please give that configuration a go.

I tested, it went fine.

This was actually fixed by:
b51fbf9fb0c3 phy-core: Don't allow building phy-core as a module

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
