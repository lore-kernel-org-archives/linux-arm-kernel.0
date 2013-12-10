From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Dec 2013 19:22:17 +0000
Subject: [Linaro-acpi] [RFC part1 PATCH 1/7] ACPI: Make ACPI core running
 without PCI on ARM64
In-Reply-To: <201312100428.52588.arnd@arndb.de>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312091735.05014.arnd@arndb.de>
 <20131209170617.GC30717@srcf.ucam.org>
 <201312100428.52588.arnd@arndb.de>
Message-ID: <20131210192217.GI11468@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 04:28:52AM +0100, Arnd Bergmann wrote:
> On Monday 09 December 2013, Matthew Garrett wrote:

> > People are trying to deploy ACPI-based embedded x86, and most of the 
> > ACPI/DT integration discussion seems to have been based on the idea that 
> > this is a worthwhile thing to support. If we're not interested in doing 
> > so then we should probably make that a whole kernel decision rather than 
> > a per architecture one.

> Well, except it's not an architecture independent decision. An embedded
> x86 SoC will still be very much like a PC, just with a few things added
> in and some other bits left out, and you can already describe it mostly

It's not just the SoC, it's also the rest of the board.  The patches the
Intel guys are submitting at the minute are mainly for the off-SoC
devices at least as far as I noticed.  This'll impact anyone who ends up
using ACPI, we need to at least pay attention to what's going on there.

> with plain ACPI-5.0. Also, there are only a couple of different non-PC style
> devices that Intel is integrating into their SoCs, so we're talking
> about a few dozen device drivers here.

It's going to be way more than that for the whole system, and you can't
assume that all the system integrators are going to pay a blind bit of
notice to the reference designs.  Some will just clone them but others
will bin them and do their own thing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131210/fc53cb0f/attachment.sig>
