From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 11 Apr 2014 11:29:21 -0600
Subject: Fixing PCIe issues on Armada XP
In-Reply-To: <CAFJTrDs4oOHCTNBcUnhQ6O0nXXA1WjbpWTPRce7vrgjzv=kQ_w@mail.gmail.com>
References: <20140410181953.50ccfcc3@skate>
 <20140410165733.GB23104@obsidianresearch.com>
 <20140410200153.46669e0c@skate>
 <20140410201201.GA12661@obsidianresearch.com>
 <alpine.DEB.2.10.1404102206090.28003@vroombuntu>
 <20140411122314.220614bf@skate>
 <20140411163129.GA20565@obsidianresearch.com>
 <CAFJTrDs4oOHCTNBcUnhQ6O0nXXA1WjbpWTPRce7vrgjzv=kQ_w@mail.gmail.com>
Message-ID: <20140411172921.GA31254@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 06:21:08PM +0100, Matthew Minter wrote:

> I would also like to note, my board uses an external clock for the
> PCI ports, thus it is unlikely to be effected by any issues relating
> to clock drivers.

It doesn't matter, the clock in question is the internal divided CPU
synchronous clock that drives the PEX TLP logic. Externally sourcing
the PHY clock won't change the synchronous side.

Jason
