From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 9 Jul 2013 14:54:00 -0400
Subject: [PATCH v7 11/22] PCI: mvebu: Adapt to the new device tree layout
In-Reply-To: <CAErSpo5uhDRWNnEvTewU=RnV7VW_em=PbvyQZh2PkEy8pCsGwg@mail.gmail.com>
References: <1373388084-29520-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1373388084-29520-12-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130709182026.GJ11908@titan.lakedaemon.net>
 <CAErSpo5uhDRWNnEvTewU=RnV7VW_em=PbvyQZh2PkEy8pCsGwg@mail.gmail.com>
Message-ID: <20130709185400.GM11908@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 12:50:47PM -0600, Bjorn Helgaas wrote:
> On Tue, Jul 9, 2013 at 12:20 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> > Bjorn,
> >
> > On Tue, Jul 09, 2013 at 01:41:13PM -0300, Ezequiel Garcia wrote:
> >> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> >>
> >> The new device tree layout encodes the window's target ID and attribute
> >> in the PCIe controller node's ranges property. This allows to parse
> >> such entries to obtain such information and use the recently introduced
> >> MBus API to create the windows, instead of using the current name based
> >> scheme.
> >>
> >> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> >> ---
> >>  .../devicetree/bindings/pci/mvebu-pci.txt          | 145 ++++++++++++++++-----
> >>  drivers/pci/host/pci-mvebu.c                       | 113 +++++++++++-----
> >>  2 files changed, 193 insertions(+), 65 deletions(-)
> >
> > After my conversation with tglx a few days ago [1], I'm even more
> > inclined to push patches like this to the correct maintainers.  However,
> > looking at how this patch fits into the series, it may be better if we
> > take it through mvebu/arm-soc with your Ack.
> >
> > It depends on the patches before it, and the patches after it depend on
> > it.  Unless I'm reading this wrong, I would have a branch that you would
> > pull and base this patch on, which I would then pull and base the rest
> > of the series on. Reshuffling the series to alleviate this wouldn't work
> > in this case. :-/
> >
> > Are you ok with that?  (fwiw, the code changes are isolated to
> > pci-mvebu.c)
> 
> Yep, that makes sense to me.  With dependencies both ways, it just
> seems much simpler to have you push it via mvebu/arm-soc.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Will do, thanks Bjorn!

thx,

Jason.
