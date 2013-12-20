From: broonie@kernel.org (Mark Brown)
Date: Fri, 20 Dec 2013 16:05:22 +0000
Subject: [PATCH 2/2] arm64: dts: Reduce size of virtio block device for
 foundation model
In-Reply-To: <20131220142524.GB11954@localhost>
References: <1387543964-15057-1-git-send-email-broonie@kernel.org>
 <1387543964-15057-2-git-send-email-broonie@kernel.org>
 <20131220142524.GB11954@localhost>
Message-ID: <20131220160522.GX31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 02:25:24PM +0000, Catalin Marinas wrote:
> On Fri, Dec 20, 2013 at 12:52:44PM +0000, Mark Brown wrote:
> > From: Mark Brown <broonie@linaro.org>

> > Will Deacon observed that kvmtool uses a size of 0x200 for virtio
> > block memory region and that the virtio block spec only uses 31 bytes in
> > the device specific region at 0x100 so reduce the region to a less
> > wasteful 0x200.

> What do we waste by keeping it at 4K? That's ioremap'ed, so we use a
> full page anyway.

This was done for consistency with the same change made in RTSM
motherboard patch so that we register the same device in the same way.  
That change was at Will's request, he did point out that we might use
16K pages in some systems IIRC but personally I'm not sure it makes a
huge difference either way - I do think we should keep all registrations
of the device consistent though to avoid user confusion about how to use
it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/656f6dec/attachment.sig>
