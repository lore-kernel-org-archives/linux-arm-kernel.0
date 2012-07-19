From: mgreer@animalcreek.com (Mark A. Greer)
Date: Thu, 19 Jul 2012 13:20:37 -0700
Subject: [PATCH 2/2] arm: omap3: am35x: Disable hlt when using Davinci EMAC
In-Reply-To: <alpine.DEB.2.00.1207191317510.14390@utopia.booyaka.com>
References: <1336770778-23044-1-git-send-email-mgreer@animalcreek.com>
 <1336770778-23044-3-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1207171814100.28834@utopia.booyaka.com>
 <20120718213246.GD27904@animalcreek.com>
 <alpine.DEB.2.00.1207181723120.19048@utopia.booyaka.com>
 <20120719182602.GB24076@animalcreek.com>
 <alpine.DEB.2.00.1207191317510.14390@utopia.booyaka.com>
Message-ID: <20120719202037.GB5264@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2012 at 01:19:13PM -0600, Paul Walmsley wrote:
> On Thu, 19 Jul 2012, Mark A. Greer wrote:
> 
> > ...and, unfortunately, it didnt' work in either case.
> 
> OK thanks for the tests.  Is the EMAC/MDIO really active and asserting 
> interrupts while all this is happening?

I should be active but I have not way to tell for sure.

> Or has that driver called 
> pm_runtime_put*(), and so the EMAC/MDIO isn't waking up? 

pm_runtime_get has definitely been called and pm_runtime_put
has definitely _not_ been called.

Mark
