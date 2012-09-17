From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 17 Sep 2012 04:34:23 -0700
Subject: [PATCH v2 1/2] PCI: Keep pci_fixup_irqs() around after init
In-Reply-To: <1347880974-13615-1-git-send-email-thierry.reding@avionic-design.de>
References: <1347880974-13615-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120917113423.GA28759@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 01:22:53PM +0200, Thierry Reding wrote:
> Remove the __init annotations in order to keep pci_fixup_irqs() around
> after init (e.g. for hotplug). This requires the same change for the
> implementation of pcibios_update_irq() on all architectures. While at
> it, all __devinit annotations are removed as well, since they will be
> useless now that HOTPLUG is always on.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
> Changes in v2:
> - remove __init and __devinit annotations altogether

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
