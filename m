From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 5 Nov 2015 13:25:52 +0100 (CET)
Subject: [PATCH RFC 0/7] Adding core support for wire-MSI bridges
In-Reply-To: <563B49F0.7040000@arm.com>
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
 <56205917.7090001@linux.intel.com> <5620B9D6.1010708@arm.com>
 <alpine.DEB.2.11.1511041348060.4032@nanos> <563B49F0.7040000@arm.com>
Message-ID: <alpine.DEB.2.11.1511051324380.4032@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Nov 2015, Marc Zyngier wrote:
> On 04/11/15 13:34, Thomas Gleixner wrote:
> > Marc,
> > 
> > On Fri, 16 Oct 2015, Marc Zyngier wrote:
> >> On 16/10/15 02:55, Jiang Liu wrote:
> >>> 	There's a working to enable Intel VMD storage device, which
> >>> has the similar requirement. Basically a PCIe hierarchy is hidden
> >>> behind a parent PCIe device, so we need to use the PCIe irqs on parent
> >>> to de-multiple PCIe IRQs from hidden PCIe devices. Seems a chance for
> >>> consolidation here.
> >>
> >> Do you know if there is a 1-1 mapping between the interrupts seen by the
> >> parent device and those seen by the hidden devices? Or is it a case of
> >> having to demultiplex the MSIs? Looks like the former, but I'd like to
> >> be sure.
> > 
> > Yes, it's a demultiplexer. No 1:1 mapping.
> 
> Right. This doesn't exactly fit the scheme I have so far (there is a 1:1
> mapping between the wired interrupt and the MSI), but once we are able
> to expose an MSI domain, it could be possible to construct the MSI
> demultiplexer on top. That's a lot of layers! ;-)

Well for the demux case it doesn't make a lot of sense. It's not easy
to describe in a hierarchy. Having that parentless MSI domain for that
VMD case is simple enough.

Thanks,

	tglx
