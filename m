From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Oct 2010 16:29:46 +0200
Subject: [PATCH 1/6] Realview PCIX support - add main support module code
In-Reply-To: <20101028140949.GE3122@n2100.arm.linux.org.uk>
References: <20101020125554.22199.78597.stgit@e102602-lin.cambridge.arm.com>
	<201010202316.33540.arnd@arndb.de>
	<20101028140949.GE3122@n2100.arm.linux.org.uk>
Message-ID: <201010281629.46913.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 October 2010, Russell King - ARM Linux wrote:
> On Wed, Oct 20, 2010 at 11:16:32PM +0200, Arnd Bergmann wrote:
> > > +{
> > > +   u32 mode;
> > > +   u32 config_addr;
> > > +
> > > +   writel(0x000307F7, PCIX_UNIT_BASE + PCI_PERRSTAT); /* clear error bit */
> > > +   writew(0xfb30, PCIX_UNIT_BASE + PCI_STATUS);       /* error bit clear */
> > 
> > I would guess that you need locking here, two drivers might simultaneously be
> > accessing config space on different CPUs, or you might have kernel preemption
> > enabled and get preempted between the register accesses.
> 
> pci config accesses are serialized by a global pci_lock raw spinlock,
> which disables IRQs.

Ok, good. Ignore my comment then.

	Arnd
