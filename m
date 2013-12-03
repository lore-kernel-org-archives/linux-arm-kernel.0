From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Dec 2013 19:51:18 +0000
Subject: [PATCH] arm64: dts: Add a virtio disk to the RTSM motherboard
In-Reply-To: <20131203194136.GB22668@mudshark.cambridge.arm.com>
References: <1386098643-30784-1-git-send-email-broonie@kernel.org>
 <20131203194136.GB22668@mudshark.cambridge.arm.com>
Message-ID: <20131203195118.GB29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 07:41:43PM +0000, Will Deacon wrote:
> On Tue, Dec 03, 2013 at 07:24:03PM +0000, Mark Brown wrote:

> > +			virtio_block at 0130000 {
> > +				compatible = "virtio,mmio";
> > +				reg = <0x130000 0x1000>;

> Can we make this 0x200 for the size? That's what kvmtool uses and, from the
> virtio-mmio spec, config data from offset 0x100+ is driver-specific. A quick
> look at the virtio block driver suggests we only use 31 bytes of that at the
> moment, so 4k is really OTT (and doesn't match the page size for 64K page
> systems anyway).

Sure, I'll send a patch to make this change for the foundation model
too.

> With that change:

>   Acked-by: Will Deacon <will.deacon@arm.com>

Thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131203/b2479a04/attachment-0001.sig>
