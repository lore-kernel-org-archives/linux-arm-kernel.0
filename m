From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 2 Mar 2017 21:08:00 +0100
Subject: [PATCH 07/20] PCI: implement Devres interface to map PCI config
 space
In-Reply-To: <20170302192406.GA8519@wtj.duckdns.org>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-8-lorenzo.pieralisi@arm.com>
 <CAHp75VfdE6_W+DxhejorLxra2JQDGF3cG0uBedyOohhmcLiKLg@mail.gmail.com>
 <20170302120546.GB17277@red-moon>
 <CAHp75VfoZTr5L3z5_SXW58W2Ate5nCWSzP8hAA051fVwizSjag@mail.gmail.com>
 <20170302192406.GA8519@wtj.duckdns.org>
Message-ID: <20170302200800.GA21303@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 02:24:06PM -0500, Tejun Heo wrote:
> Hello,
> 
> On Thu, Mar 02, 2017 at 02:50:00PM +0200, Andy Shevchenko wrote:
> > > I thought about that and did not do it because here we are remapping
> > > resources that are _not_ PCI bus resources (ie it is not PCI BARs we
> > > are remapping), keeping the devm_* prefix would be more consistent
> > > to the typical device drivers remapping functions pattern (ie a
> > > typical PCI host controller driver would mix devm_ and pcim_ calls
> > > which is a bit hard to parse), that was my rationale.
> > >
> > > I am not too fussed about that either way, I am happy to update it to
> > > pcim_* though, it is Bjorn/Arnd's decision.
> > 
> > I would vote for pcim_*() variant.
> 
> Me too, for brevity.

devm_* is equally brief. Also, all existing pcim_*() functions take a
struct pci_dev * as their first argument, because they operate on the
PCI devices. However in this case the devm_pci_remap_*() functions do
not operate on PCI devices. Rather they operate on the struct device
that represents the PCI host bridge. Therefore I think devm_ is more
appropriate here.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170302/9057b514/attachment.sig>
