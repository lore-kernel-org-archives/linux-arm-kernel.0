From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 26 Apr 2012 12:56:47 -0600 (MDT)
Subject: [PATCH-V3 2/3] ARM: OMAP3+: clockdomain33xx: Add clockdomain
 data and respective operations
In-Reply-To: <79CD15C6BA57404B839C016229A409A83E9FF79B@DBDE01.ent.ti.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
 <1333458578-23073-3-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204241725430.24864@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9FD30E@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204252118170.30642@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9FE75B@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204260252240.10308@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9FF79B@DBDE01.ent.ti.com>
Message-ID: <alpine.DEB.2.00.1204261252430.10308@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Apr 2012, Hiremath, Vaibhav wrote:

> On Thu, Apr 26, 2012 at 14:27:20, Paul Walmsley wrote:

(attribution lost)

> > > I am thinking of separating clocktree patch (PATCH-V3 3/3) from this series, 
> > > so that clockdomain stuff can get in independently, and clocktree anyway 
> > > will follow them (it may take some time in review cycle).
> > 
> > Yes, I was thinking of doing this too.  The only aspect that gave me pause 
> > is that the clockdomain changes are not 100% separate from the clock tree.  
> > So we may have to update the clockdomain data as the clock tree changes.
> 
> Why do you say that, clockdomain changes are not 100% separate from 
> clocktree? It is completely independent...

Clock enables and disables call clkdm_clk_{enable,disable}() which 
undertakes the clockdomain enable sequence on the first clock enabled 
inside the clockdomain, and the clockdomain disable sequence on the last 
clock inside the clockdomain.  The clockdomain is associated with the 
clock via the struct clk .clkdm and .clkdm_name fields.

So yes, they are interconnected; particularly if the clkdiv32k MODULEMODE 
"clock" is really needed.


- Paul
