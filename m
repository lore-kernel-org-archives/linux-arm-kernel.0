From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Feb 2014 14:23:23 +0100
Subject: [PATCH v2 10/23] ARM: MM: Add DT binding for Feroceon L2 cache
In-Reply-To: <1392459621-24003-11-git-send-email-andrew@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <1392459621-24003-11-git-send-email-andrew@lunn.ch>
Message-ID: <2979047.tn4oVevojb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 15 February 2014 11:20:08 Andrew Lunn wrote:
> Instantiate the L2 cache from DT. Indicate in DT where the cache
> control register is and if write through should be made.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> cc: devicetree at vger.kernel.org
> 

I guess this answers part of my question for patch 5, but I also
wonder if the run-time setting is correct now with the hardcoded
#ifdef in arch/arm/mm/proc-feroceon.S checkign for the
Kconfig option. Presumably the code should match whatever is
set in the cache control register.

	Arnd
