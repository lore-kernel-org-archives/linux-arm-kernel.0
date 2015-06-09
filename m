From: broonie@kernel.org (Mark Brown)
Date: Wed, 10 Jun 2015 00:20:29 +0100
Subject: [PATCH 02/15] regmap: kill off set_irq_flags usage
In-Reply-To: <20150609212709.GJ7557@n2100.arm.linux.org.uk>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
 <1433874401-27161-3-git-send-email-robh@kernel.org>
 <20150609191211.GA14071@sirena.org.uk>
 <20150609212709.GJ7557@n2100.arm.linux.org.uk>
Message-ID: <20150609232029.GB14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 09, 2015 at 10:27:09PM +0100, Russell King - ARM Linux wrote:

> It's because there exist platforms where specific IRQs are permanently
> asserted, and unexpectedly claiming such an interrupt (eg, through IRQ
> probing) would lock the system - at least before we ended up with the
> detection in genirq (which has its roots in the ARM code.)

Ah, yes - now I remember.  I just had a vauge recollection of broken
probing.

> I'd suggest people think carefully about applying these patches.  They
> have only been around for a matter of hours, so to rush to apply them
> when they haven't been revewied as a whole to assess whether the approach
> is the right one is rather hasty.

I'm fairly comfortable with the patch for regmap as that code is
architecture neutral, should already have been consistent and the
non-ARM path has definitely been tested (I've done it myself).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150610/2c153884/attachment.sig>
