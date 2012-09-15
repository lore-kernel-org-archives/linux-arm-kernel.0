From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sat, 15 Sep 2012 09:57:37 +0200
Subject: [PATCH 1/2] PCI: Annotate pci_fixup_irqs with __devinit
In-Reply-To: <20120914223531.GA8771@kroah.com>
References: <1347655456-2542-1-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo6BqPUEpMmh2+FuEi-mHFK0U1XCmdCpJfo6V2XcNxzMNg@mail.gmail.com>
 <20120914223531.GA8771@kroah.com>
Message-ID: <20120915075737.GA31258@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 03:35:31PM -0700, Greg Kroah-Hartman wrote:
> On Fri, Sep 14, 2012 at 02:53:11PM -0600, Bjorn Helgaas wrote:
> > +cc Greg KH
> > 
> > On Fri, Sep 14, 2012 at 2:44 PM, Thierry Reding
> > <thierry.reding@avionic-design.de> wrote:
> > > In order to keep pci_fixup_irqs() around after init (e.g. for hotplug),
> > > mark it __devinit instead of __init. This requires the same change for
> > > the implementation of the pcibios_update_irq() function on all
> > > architectures.
> > >
> > > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > > ---
> > > Note: Ideally these annotations should go away completely in order to
> > > be independent of the HOTPLUG symbol. However, there is work underway
> > > to get rid of HOTPLUG altogether, so I've kept the __devinit for now.
> 
> No, just take away the __init marking completly.  For 3.7,
> CONFIG_HOTPLUG will always be enabled, making it be the same thing.
> That way this saves me the time and energy from deleting the __devinit
> markings when I get to that point in the patch series :)

Done. I'll give other people some time to comment before sending the
updated series.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120915/3d83027b/attachment.sig>
