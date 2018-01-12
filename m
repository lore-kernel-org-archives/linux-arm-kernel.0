From: tony@atomide.com (Tony Lindgren)
Date: Fri, 12 Jan 2018 06:14:56 -0800
Subject: PM regression in next
In-Reply-To: <20180112135526.GC29734@lunn.ch>
References: <20180112000037.GA3875@atomide.com>
 <20180112013257.GB4059@atomide.com>
 <4913146.sVL6sFxzC8@aspire.rjw.lan>
 <4745593.FguGN2uIkX@aspire.rjw.lan>
 <e7a673e1-b28d-f84e-c6c1-c5b896e92aeb@metafoo.de>
 <20180112131623.GA29734@lunn.ch>
 <20180112135203.GA4821@atomide.com>
 <20180112135526.GC29734@lunn.ch>
Message-ID: <20180112141456.GB4821@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andrew Lunn <andrew@lunn.ch> [180112 13:55]:
> > Thanks that fixes the suspend error. And I was able to confirm
> > that the suspend power consumption is OK.
> > 
> > That still leaves the mystery of the runtime idle power consumption
> > being much higher with commit e130bc1d00a4.
> 
> Did you re-measure the runtime power? Do you have an unused PHY? It
> could be it is not getting shut down. 1G PHYs can be quite power
> hungry.

Yes this is a different issue, the increase in runtime PM
consumption measurement I'm measuring is for a SoM board.
It contains the SoC + memory + PMIC and few devices. The
Ethernet controller is on a separate optional base board
and not related to the runtime PM issue.

Regards,

Tony
