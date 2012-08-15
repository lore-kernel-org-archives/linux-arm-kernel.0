From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 15 Aug 2012 21:28:14 +0200
Subject: [PATCH v3 01/10] PCI: Keep pci_fixup_irqs() around after init
In-Reply-To: <CAErSpo7v+i8i=mXCs7ZW8DtGTDN_4AEntwYLqGG8FcCzweySFg@mail.gmail.com>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-2-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo7v+i8i=mXCs7ZW8DtGTDN_4AEntwYLqGG8FcCzweySFg@mail.gmail.com>
Message-ID: <20120815192814.GA12870@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 10:06:27AM -0700, Bjorn Helgaas wrote:
> On Thu, Jul 26, 2012 at 12:55 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > When using deferred driver probing, PCI host controller drivers may
> > actually require this function after the init stage.
> >
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> > Changes in v3:
> > - none
> >
> > Changes in v2:
> > - use __devinit annotations
> 
> Your original patch removed __init completely.  Here you change it to
> __devinit.  That means we decide whether to discard the function based
> on whether CONFIG_HOTPLUG is supported.  But I think your point is not
> about hotplug; it's merely that we should be able to scan a PCI bus
> after init-time.  We ought to be able to do a late PCI scan even if
> hotplug is not supported.
> 
> Therefore, I'd be inclined to remove __init completely unless you have
> another reason for preferring __devinit.

I thought __devinit would resolve to nothing if HOTPLUG is defined and
__init otherwise. That seemed more appropriate. However you are right
that it is useful to always have it available, so I'm fine with removing
the annotations altogether. Do you want me to follow up with a patch? Or
can you just take the first version? I'm not sure if it still applies.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120815/74a964da/attachment-0001.sig>
