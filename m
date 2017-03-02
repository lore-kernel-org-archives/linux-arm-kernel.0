From: tj@kernel.org (Tejun Heo)
Date: Thu, 2 Mar 2017 14:24:06 -0500
Subject: [PATCH 07/20] PCI: implement Devres interface to map PCI config
 space
In-Reply-To: <CAHp75VfoZTr5L3z5_SXW58W2Ate5nCWSzP8hAA051fVwizSjag@mail.gmail.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-8-lorenzo.pieralisi@arm.com>
 <CAHp75VfdE6_W+DxhejorLxra2JQDGF3cG0uBedyOohhmcLiKLg@mail.gmail.com>
 <20170302120546.GB17277@red-moon>
 <CAHp75VfoZTr5L3z5_SXW58W2Ate5nCWSzP8hAA051fVwizSjag@mail.gmail.com>
Message-ID: <20170302192406.GA8519@wtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Mar 02, 2017 at 02:50:00PM +0200, Andy Shevchenko wrote:
> > I thought about that and did not do it because here we are remapping
> > resources that are _not_ PCI bus resources (ie it is not PCI BARs we
> > are remapping), keeping the devm_* prefix would be more consistent
> > to the typical device drivers remapping functions pattern (ie a
> > typical PCI host controller driver would mix devm_ and pcim_ calls
> > which is a bit hard to parse), that was my rationale.
> >
> > I am not too fussed about that either way, I am happy to update it to
> > pcim_* though, it is Bjorn/Arnd's decision.
> 
> I would vote for pcim_*() variant.

Me too, for brevity.

> >> 2. If you may notice there is no separate pcim_*map*() stuff, they are
> >> dynamically adapting to the case.
> >
> > I do not understand what you mean here I would ask you to elaborate
> > a bit more please so that I can do something about it.
> 
> Oh, sorry, there are two examples currently, i.e.
> pci_enable_msi()/pci_enable_msix() and pci_request_region*() which has
> no "m" in the name, but are managed on release by pcim_release().
> Some developers consider this as a bad idea, but so far no patch has
> been sent to introduce pcim_*() variants of those.
>
> So, regarding to your stuff, I would stick with "pcim" prefix.

Sounds good to me.

Thanks.

-- 
tejun
