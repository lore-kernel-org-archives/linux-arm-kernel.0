From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 30 May 2014 11:30:53 -0600
Subject: [PATCH 0/8] i.MX6 PCIe binding change and MSI support
In-Reply-To: <1399885183.5016.4.camel@weser.hi.pengutronix.de>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
 <20140424175844.GD29593@google.com>
 <1398421265.4657.25.camel@weser.hi.pengutronix.de>
 <CAErSpo7Boi8d+apAUC3TmmE33LuRMYJ6J+TEPLRbeyZyU3O8RQ@mail.gmail.com>
 <1398774686.4677.12.camel@weser.hi.pengutronix.de>
 <1399885183.5016.4.camel@weser.hi.pengutronix.de>
Message-ID: <20140530173053.GF4607@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 10:59:43AM +0200, Lucas Stach wrote:
> Hi Bjorn,
> 
> just a friendly reminder. It would be nice if you could pull those in.
> 
> Shawn already pulled the DT change and as it is a binding change this
> means PCIe on i.MX6 is broken in -next, as long as the remaining patches
> are missing.

I applied these to pci/host-imx6 for v3.16.

Sorry I didn't do this sooner; I get a lot of email and it's easy to
overlook things.  I mostly work from patchwork
(http://patchwork.ozlabs.org/project/linux-pci/list/?order=date), and I had
dropped this series from there because there was enough discussion that I
expected a re-post, so it wasn't on my radar screen anymore.

Bjorn

> Am Dienstag, den 29.04.2014, 14:31 +0200 schrieb Lucas Stach:
> > Hi Bjorn,
> > 
> > Am Freitag, den 25.04.2014, 08:39 -0600 schrieb Bjorn Helgaas:
> > [...]
> > > >> >   PCI: designware: split Exynos and i.MX bindings
> > > >> >   ARM: dts: imx6: update pcie to bring in line with new binding
> > > >> >   PCI: imx6: use new clock names
> > > >> >   PCI: imx6: drop old irq mapping
> > > >> >   PCI: imx6: rip out optional (and unused) irqs
> > > >> >   PCI: designware: make MSI isr shared irq aware
> > > >> >   PCI: imx6: add support for MSI
> > > >>
> > > >> What's the status of all these?  I would normally apply patches 4-8 of this
> > > >> series through my tree, given the appropriate acks, but I haven't seen
> > > >> those yet.  And I'm not sure what dependencies there are between the
> > > >> non-PCI patches and the PCI ones.
> > > >>
> > > > It's a complete binding change, so applying one part without the other
> > > > is going to horribly break things.
> > > >
> > > > So I would at least want to see an ack for the binding change on the
> > > > i.MX side from Shawn and Richard. This will need some follow on patches,
> > > > as some boards adding PCIe using the old binding have cropped up in
> > > > linux-next, but I can do the patches on short notice if everyone agrees
> > > > to merge this patchset.
> > > >
> > > > The designware part is pretty simple and doesn't change anything for
> > > > other users than i.MX. Though I would like to see an ack from Jingoo for
> > > > those.
> > > >
> > > > I have some more stuff in the pipes regarding multiple MSI irqs, that
> > > > depend on this series and also the Keystone people are waiting for this
> > > > to be applied in order to consolidate the clock handling of the
> > > > designware core driver, so it would be nice to get this moving again.
> > > 
> > > OK, just poke me again when you're ready for me to do something with these.
> > > 
> > 
> > As both Richard and Jingoo gave their ack for the respective patches I
> > think this is good to go in and I would expect all the PCI patches to go
> > through your tree for 3.16.
> > 
> > Shawn, if you are not okay with this change, please speak up now.
> > Otherwise please pick the dts change for 3.16. I'll go over linux-next
> > and prepare the patches to fix up the boards there.
> > 
> 
> 
> -- 
> Pengutronix e.K.             | Lucas Stach                 |
> Industrial Linux Solutions   | http://www.pengutronix.de/  |
> 
