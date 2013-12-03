From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Dec 2013 12:43:27 +0000
Subject: [PATCH] arm64: dts: Add a virtio disk to the RTSM motherboard
In-Reply-To: <20131203114217.GF1169@mudshark.cambridge.arm.com>
References: <1386001475-20728-1-git-send-email-broonie@kernel.org>
 <20131203114217.GF1169@mudshark.cambridge.arm.com>
Message-ID: <20131203124327.GT27568@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 11:42:18AM +0000, Will Deacon wrote:
> On Mon, Dec 02, 2013 at 04:24:35PM +0000, Mark Brown wrote:

> > +			virtio_block at 0130000 {
> > +				compatible = "virtio,mmio";
> > +				reg = <0x130000 0x1000>;

> 4k? That seems pretty big to me...

Yeah, it looks like a page size to me though it does also seem like the
sort of nice round number devices tend to offer.  The binding document
is depressingly silent on the topic of the size of the region but the
only existing in tree user (the ARMv8 foundation model DTS) also picks
the same number.

> > +				interrupts = <0x2a>;

> Any reason this is in hex?

That's what it was in Mark's original patch, easy enough to update.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131203/8335c3c2/attachment-0001.sig>
