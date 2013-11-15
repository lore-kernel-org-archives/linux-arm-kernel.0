From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 15 Nov 2013 11:28:26 -0700
Subject: ACPI vs DT at runtime
In-Reply-To: <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
Message-ID: <20131115182826.GB14920@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 09:57:17AM +0000, Mark Rutland wrote:

> first-class citizen. We don't need to modify every driver and subsystem
> to support ACPI, only those necessary to support the minimal set of
> platforms using ACPI. ACPI is new in the arm space, and we can enforce
> quality standards on ACPI _now_ above what we're allowing for DT, and
> avoid future problems.

I think to replicate the kind of 'success' ACPI sees in x86-land you
really need to push back on the HW folks and limit what drivers will
be supported on ACPI systems.

ACPI should be coupled with a standard basic HW environment -
analogous to the stable APIC, PCI and HPET standards we have in
x86. (ARMv8 only?)

Other essential devices (ethernet, graphics, etc) should fit within
the PCI framework. Again, mostly like x86.

If you don't fit in that model then use DT.

If you need the kernel to control clk, pinctrl, regulator, etc then
you should be using DT.

If you need a special one-off HW driver to boot to a console then you
should be using DT ;)

DT is here, it is working, it seems viable to set a strong goal for
ACPI and shift everything else to DT:

 ACPI systems should have the broad compatability we see in x86. New
 hardware bought today should still boot a 3 year old OS.

Jason
