From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 19 Nov 2013 15:59:18 +0100
Subject: ACPI vs DT at runtime
In-Reply-To: <20131119143840.GN5914@e106331-lin.cambridge.arm.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <20131115175241.GB27174@quad.lixom.net>
 <20131119113015.GH5914@e106331-lin.cambridge.arm.com>
 <alpine.DEB.2.02.1311191304260.27757@kaball.uk.xensource.com>
 <20131119143840.GN5914@e106331-lin.cambridge.arm.com>
Message-ID: <20131119145917.GC24997@rocoto.smurfnet.nu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 02:38:40PM +0000, Mark Rutland wrote:
> > > For that case we will also require a nailed-down boot
> > > protocol that allows for either DTB or ACPI.
> > 
> > The latest documentation patch for the "arm/arm64 UEFI boot protocol"
> > implies that UEFI on ARM is already capable of passing a DTB to the
> > kernel:
> > 
> > "The implementation depends on receiving information about the UEFI
> > environment in a Flattened Device Tree (FDT) - so is only available with
> > CONFIG_OF."
> > 
> > Maybe we just need to better document it?
> 
> Yes, we just need to document it.

Better document it than what is currently in Booting?

> As far as I'm aware, there are two ways we might boot the kernel:
 
Nope, just one.

> 1) Via the current boot protocol, passing a DTB in a particular
> register.
 
This is the only bit relevant to the kernel proper. It does not change
with UEFI/ACPI.

> 2) As an EFI application. As I understand it in this case the DTB will
> be saved in a system table (I may have got the terminology wrong here),
> and the EFI stub will need to look it up to pass it to the kernel.
 
This applies only to the stub itself, and relates to dealing with a
firmware that provides a preloaded tree. As well as an obscurity
relating to _stub_ command line passing.

It has also not been included in the patch sets sent out so far.

> As long as that's well defined and does not preclude ACPI, then I am
> happy.

This is already well defined. I'll agree it may not be explicit enough.
If we do need any documentation changes, I feel they belong in Booting,
to explain that a minimal DT will be used even with ACPI in order _not_
to break the existing boot protocol.

/
    Leif
