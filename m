From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 25 Aug 2012 17:41:08 +0200
Subject: [3.6-rc3 regression] sata_mv cannot get optional clkdev breaking
 boot on QNAP TS-119P+
In-Reply-To: <20120825151524.GH9886@lunn.ch>
References: <20536.52397.140042.917795@pilspetsen.it.uu.se>
 <20120825151524.GH9886@lunn.ch>
Message-ID: <20536.61972.508189.308675@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Lunn writes:
 > On Sat, Aug 25, 2012 at 03:01:33PM +0200, Mikael Pettersson wrote:
 > > My Kirkwood-based QNAP TS-119P+ boots fine with the 3.5 kernel.  With
 > > 3.6-rc2 and 3.6-rc3 however sata_mv complains:
 > > 
 > > sata_mv sata_mv.0: cannot get optional clkdev
 > > sata_mv sata_mv.0: slots 32 ports 2
 > > 
 > > and then the kernel grinds to a halt with no further messages.
 > > 
 > > Full boot log from 3.6-rc3 appended below.  .config available upon
 > > request, but this is a non-DT kernel.
 > 
 > Hi Mikael
 > 
 > This is a known issue. See:
 > 
 > http://comments.gmane.org/gmane.linux.ports.arm.kernel/181989
 > 
 > There are patches being developed to fix this. I hope we can push them
 > to an RC soon.

Thanks for the pointer.  Aaro Koskinen's suggestion of passing
coherent_pool=1M to the kernel allowed it to boot successfully.
I'll use that workaround for now.

/Mikael
