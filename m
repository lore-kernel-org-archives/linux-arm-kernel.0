From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 19 Jul 2012 13:19:13 -0600 (MDT)
Subject: [PATCH 2/2] arm: omap3: am35x: Disable hlt when using Davinci EMAC
In-Reply-To: <20120719182602.GB24076@animalcreek.com>
References: <1336770778-23044-1-git-send-email-mgreer@animalcreek.com>
 <1336770778-23044-3-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1207171814100.28834@utopia.booyaka.com>
 <20120718213246.GD27904@animalcreek.com>
 <alpine.DEB.2.00.1207181723120.19048@utopia.booyaka.com>
 <20120719182602.GB24076@animalcreek.com>
Message-ID: <alpine.DEB.2.00.1207191317510.14390@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Jul 2012, Mark A. Greer wrote:

> ...and, unfortunately, it didnt' work in either case.

OK thanks for the tests.  Is the EMAC/MDIO really active and asserting 
interrupts while all this is happening?  Or has that driver called 
pm_runtime_put*(), and so the EMAC/MDIO isn't waking up? 


- Paul
