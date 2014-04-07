From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 07 Apr 2014 13:16:56 +0200
Subject: [PATCH v7 1/6] pci: Introduce pci_register_io_range() helper
 function.
In-Reply-To: <1396862008.3671.39.camel@pasglop>
References: <1394811272-1547-1-git-send-email-Liviu.Dudau@arm.com>
 <20140407083550.GF17163@e106497-lin.cambridge.arm.com>
 <1396862008.3671.39.camel@pasglop>
Message-ID: <4164782.o9VMXFGud6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 April 2014 19:13:28 Benjamin Herrenschmidt wrote:
> On Mon, 2014-04-07 at 09:35 +0100, Liviu Dudau wrote:
> > Thanks for the summary, is really useful as I was recently looking
> > into code in that
> > area. One thing I was trying to understand is why ppc needs _IO_BASE
> > at all rather
> > than using the generic PCI_IOBASE? 
> 
> Perhaps because our code predates it ?  I haven't looked much into
> the semantics of PCI_IOBASE yet...

Yes, I'm pretty sure that's all there is to it. PCI_IOBASE just
happened to be an identifier we picked for asm-generic, but the
use on PowerPC is much older than the generic file.

	Arnd
