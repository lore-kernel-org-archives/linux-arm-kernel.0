From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 18 Sep 2012 20:14:39 +0200
Subject: [PATCH 1/2] ARM: pci: Keep pci_common_init() around after init
In-Reply-To: <CAErSpo7bix_4bayh2ha_yogwNiLACU7Bymd_H5ur1wxF-tmTNw@mail.gmail.com>
References: <1347657078-32230-1-git-send-email-thierry.reding@avionic-design.de>
 <1347657078-32230-2-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo7bix_4bayh2ha_yogwNiLACU7Bymd_H5ur1wxF-tmTNw@mail.gmail.com>
Message-ID: <20120918181439.GB29360@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 11:13:23AM -0600, Bjorn Helgaas wrote:
> On Fri, Sep 14, 2012 at 3:11 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > When using deferred driver probing, PCI host controller drivers may
> > actually require this function after the init stage.
> >
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> >  arch/arm/kernel/bios32.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> > index 2b2f25e..7288093 100644
> > --- a/arch/arm/kernel/bios32.c
> > +++ b/arch/arm/kernel/bios32.c
> > @@ -423,7 +423,7 @@ static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> >         return irq;
> >  }
> >
> > -static void __init pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
> > +static void __devinit pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
> 
> Shouldn't we just remove __init completely, since Greg KH is in the
> process of removing __devinit?

Yes, we probably should. In fact I have a patch on top of this marked
work-in-progress that I forgot to squash into this. That patch includes
the removal of __devinit for pcibios_update_irq() that should be covered
by a different patch I sent a few days ago as well as pcibios_swizzle()
and pcibios_init_resources(). I'll squash it into this patch and will
resend.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120918/1d937aaa/attachment.sig>
