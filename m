From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 9 Sep 2012 21:55:21 +0100
Subject: [PATCH] ARM: Dove: allow PCI to be disabled
In-Reply-To: <20120909204705.GD3451@lunn.ch>
References: <E1TAnGn-00086i-Lb@rmk-PC.arm.linux.org.uk>
 <20120909204705.GD3451@lunn.ch>
Message-ID: <20120909205521.GI13739@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 09, 2012 at 10:47:05PM +0200, Andrew Lunn wrote:
> On Sun, Sep 09, 2012 at 08:34:13PM +0100, Russell King wrote:
> > Allow PCI support for Dove to be disabled.  Some platforms do not have
> > anything connected to the PCIe ports, so requiring PCI support to be
> > built into the kernel just wastes space, and presents a lot more config
> > options than are necessary.
> > 
> > However, select USB_ARCH_HAS_EHCI so that we can still have EHCI
> > support.
> 
> Hi Russel
> 
> I have a patch in GregKH usb-next which also ensures USB_ARCH_HAS_EHCI
> is selected.
> 
> http://git.kernel.org/?p=linux/kernel/git/gregkh/usb.git;a=commitdiff;h=ba2f9dff6c914b91005f687a9d75c8eac110d323
> 
> So we might not need your select as well, although it does not harm.

That depends on how this patch is handled.  If it gets into mainline via
a separate path to GregKH's USB tree, then it must be kept together as
otherwise it _will_ cause regressions - namely EHCI becomes impossible
to select when PCI=n.  That in turn makes the CuBox (and probably other
Dove platforms) a rather useless display-only platform...
