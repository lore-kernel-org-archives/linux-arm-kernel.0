From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 21 Nov 2013 16:37:43 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <20131119181959.GA20967@quad.lixom.net>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.
 com> <20131115095717.GC1709@e106331-lin.cambridge.arm.com> <20131115175241.
 GB27174@quad.lixom.net> <20131119113015.GH5914@e106331-lin.cambridge.arm.
 com> <20131119181959.GA20967@quad.lixom.net>
Message-ID: <20131121163743.E45BFC406A3@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Nov 2013 10:19:59 -0800, Olof Johansson <olof@lixom.net> wrote:
> I think we're getting bogged down by the hypothetical AML-in-DT case. We won't
> know if we want/need it until we see what kind of stuff vendors think they will
> need to do in AML. On x86 it's mostly used to abstract out per-board
> differences, not whole SoC behavior. It also depends on how much of their
> hardware differences the silicon vendors decide to punt to software to manage
> -- that's going to work a lot less well in this type of environment than it
> does on 32-bit today.

I'm going to go out on a limb here and say flat out "no" to AML in DT.
AML in DT makes no sense to me. I've resisted any attempts to add a
bytecode to FDT. The whole model we've been working on with DT is
describe the hardware as competently as possible and expect device
drivers to bind on the platform to handle the fiddly bits. ACPI takes
the opposite approach and I don't want to go down the path of pushing
functionality out to the platform when using the DT infrastructure.

... That said, I'm not opposed to the ACPI and DT subsystems making use
of shared infrastructure wherever possible.

> > If a vendor does this, with a DTB that correctly describes their
> > hardware then I am not against it (and would prefer this case to mapping
> > from ACPI to DT). For that case we will also require a nailed-down boot
> > protocol that allows for either DTB or ACPI (only one at a time).
> 
> UEFI already allows this, as far as I know? Even if both are passed, we can
> easily make DT take precedence over ACPI, just like DT overrides ATAGs today.

Yes, there is no problem with a platform passing both DT and ACPI.

g.
