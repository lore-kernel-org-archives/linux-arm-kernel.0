From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 30 Nov 2011 13:52:09 +0000
Subject: [PATCH v3 2/5] ARM: vexpress: Get rid of MMIO_P2V
In-Reply-To: <201111301348.54350.arnd@arndb.de>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <201111292115.10833.arnd@arndb.de>
 <1322652891.3164.144.camel@hornet.cambridge.arm.com>
 <201111301348.54350.arnd@arndb.de>
Message-ID: <1322661129.3180.0.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-30 at 13:48 +0000, Arnd Bergmann wrote:
> On Wednesday 30 November 2011, Pawel Moll wrote:
> > > and so on. This ends up being more readable IMHO because it
> > > means you don't have to know what the macro does.
> > 
> > I wouldn't mind that, it's just that the V2M_PERIPH is also used in the
> > map_desc:
> > 
> > static struct map_desc v2m_io_desc[] __initdata = {
> >         {
> >                 .virtual        = V2M_PERIPH,
> > 
> > and as the .virtual is unsigned long I'd need a cast in one place or the
> > other.
> 
> I have patches for other platforms to do the same conversion and
> add the cast here, but also plan to change the way that I/O mappings
> are done in the long run, you have to specify the virtual address
> as __iomem* instead of an integer anyway.

Fine, in this case I'll do the same.

Cheers!

Pawe?
