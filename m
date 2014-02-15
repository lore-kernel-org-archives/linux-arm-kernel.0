From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 15 Feb 2014 14:59:30 +0100
Subject: [PATCH v2 10/23] ARM: MM: Add DT binding for Feroceon L2 cache
In-Reply-To: <2979047.tn4oVevojb@wuerfel>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <1392459621-24003-11-git-send-email-andrew@lunn.ch>
 <2979047.tn4oVevojb@wuerfel>
Message-ID: <20140215135930.GA26088@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 15, 2014 at 02:23:23PM +0100, Arnd Bergmann wrote:
> On Saturday 15 February 2014 11:20:08 Andrew Lunn wrote:
> > Instantiate the L2 cache from DT. Indicate in DT where the cache
> > control register is and if write through should be made.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > cc: devicetree at vger.kernel.org
> > 
> 
> I guess this answers part of my question for patch 5, but I also
> wonder if the run-time setting is correct now with the hardcoded
> #ifdef in arch/arm/mm/proc-feroceon.S checkign for the
> Kconfig option. Presumably the code should match whatever is
> set in the cache control register.

Humm, yes, good point.

None of the _defconfig's ever turn on
CACHE_FEROCEON_L2_WRITETHROUGH. I also did a quick google and could
not find any usage of it.

So i see two options:

1) Remove the wr-override from the DT binding and use
CACHE_FEROCEON_L2_WRITETHROUGH.

2) Remove CACHE_FEROCEON_L2_WRITETHROUGH and make proc-feroceon.S do
the right thing at runtime.

I suspect i will go for 1), it is simpler.

  Thanks
	Andrew
