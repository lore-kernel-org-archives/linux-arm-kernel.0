From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 12 Jun 2011 11:47:59 -0400 (EDT)
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <20110612151931.GK10283@n2100.arm.linux.org.uk>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<20110612112219.GD16318@ibawizard.net>
	<20110612115820.GF10283@n2100.arm.linux.org.uk>
	<201106121615.24059.arnd@arndb.de>
	<20110612145751.GA4013@ponder.secretlab.ca>
	<20110612151931.GK10283@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1106121145570.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 12 Jun 2011, Russell King - ARM Linux wrote:

> On Sun, Jun 12, 2011 at 08:57:51AM -0600, Grant Likely wrote:
> > On Sun, Jun 12, 2011 at 04:15:23PM +0200, Arnd Bergmann wrote:
> > > But when you have both atag and DT and the atag overrides the DT, that
> > > means we have incorrect information in the DT, and code might later
> > > rely on that information.
> > > 
> > > IMHO when we allow passing a DT to a kernel while booting from an
> > > existing boot loader that only knows about atag, the code that loads
> > > the DT should be responsible for updating the DT with the atag information,
> > > not pass two conflicting sets of data into the actual kernel.
> > 
> > I completely agree here.  I /started/ from the position that ATAGs and
> > DTB would coexist, and after extensive debate[1] my opinion turned around
> > to it should be one or the other.  Otherwise there are all kinds of
> > questions about accuracy of the information and which takes
> > precedence.
> 
> And we've ended up with a fucked up situation which is extremely
> fragile, and actually makes me _NOT_ want to convert any existing
> platforms to use DT in the least.

Agreed.  I don't think that anything older than OMAP2 is worth 
converting to DT.  The return on the investment is simply not worth it, 
other than for experimental purposes.


Nicolas
