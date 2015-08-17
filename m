From: will.deacon@arm.com (Will Deacon)
Date: Mon, 17 Aug 2015 10:01:32 +0100
Subject: [PATCH v2 2/4] PCI: pci-host-generic: Fix lookup of
 linux,pci-probe-only property
In-Reply-To: <CAErSpo5abs2Qj25Bs+JVg87ve346f_RVz7jhNwqdv856+WvXQA@mail.gmail.com>
References: <1439569159-10051-1-git-send-email-marc.zyngier@arm.com>
 <1439569159-10051-3-git-send-email-marc.zyngier@arm.com>
 <20150814164051.GF26431@google.com>
 <20150814164324.GC22809@arm.com>
 <CAErSpo5abs2Qj25Bs+JVg87ve346f_RVz7jhNwqdv856+WvXQA@mail.gmail.com>
Message-ID: <20150817090132.GC1688@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 09:26:21PM +0100, Bjorn Helgaas wrote:
> On Fri, Aug 14, 2015 at 11:43 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Aug 14, 2015 at 05:40:51PM +0100, Bjorn Helgaas wrote:
> >> Do we need support for pci-probe-only in pci-host-generic at all?
> >> You're removing the use in amd-overdrive.dts, and there are no other
> >> DTs in the kernel tree that mention it.
> >>
> >> If we can live without it, that would be nice.  It seems like a relic from
> >> days when we couldn't reliably assign resources.  (I'm not saying we can do
> >> that reliably even today, but I'd rather make it reliable than turn it
> >> off.)
> >
> > Kvmtool certainly uses it (and generates its own DT, hence why you don't
> > see it in mainline). Not sure about qemu, though.
> 
> Do you know why kvmtool wants probe-only?  Would something break if we
> didn't support probe-only?  I guess we'd be looking for a case where
> Linux assigns resources and that assignment doesn't work with kvmtool?

It's basically because the BARs aren't writable other than to find the
region size. It could fixed with a bit of pain, but it doesn't help older
kvmtools that do work with mainline today.

Will
