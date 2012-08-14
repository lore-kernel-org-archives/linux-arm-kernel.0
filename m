From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 14 Aug 2012 07:37:55 +0200
Subject: [PATCH v3 01/10] PCI: Keep pci_fixup_irqs() around after init
In-Reply-To: <CAErSpo5YDwstHv7B7LEbDQmnHnuVsMA2ibTFNLkiCKmkkeE4Zw@mail.gmail.com>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-2-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo5YDwstHv7B7LEbDQmnHnuVsMA2ibTFNLkiCKmkkeE4Zw@mail.gmail.com>
Message-ID: <20120814053755.GA16181@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2012 at 10:06:38PM -0700, Bjorn Helgaas wrote:
> On Thu, Jul 26, 2012 at 12:55 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > When using deferred driver probing, PCI host controller drivers may
> > actually require this function after the init stage.
> 
> Yes, this is a bug.  Actually, there's still another bug here: if we
> hot-add a device, we won't do pdev_fixup_irq() for it.  But your
> change is worthwhile even without fixing that other bug.
> 
> Normally I would include this in my PCI tree since it's under
> drivers/pci.  That would make it easier for somebody to fix the
> hotplug problem in this cycle.  Would having it in my PCI tree make
> things harder for you?

No, not at all.

> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120814/aa4196d7/attachment.sig>
