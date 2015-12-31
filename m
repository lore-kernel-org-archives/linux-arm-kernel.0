From: broonie@kernel.org (Mark Brown)
Date: Thu, 31 Dec 2015 22:14:07 +0000
Subject: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
In-Reply-To: <1451599146.9673.2.camel@collins>
References: <568088B4.6090207@ti.com> <1451342963.14631.13.camel@collins>
 <5681D7A8.2030101@ti.com> <1451387613.18148.9.camel@collins>
 <568323B7.7080101@ti.com> <1451464521.2531.4.camel@collins>
 <20151230163307.GW16023@sirena.org.uk>
 <1451500639.14341.6.camel@collins>
 <20151231214007.GC16023@sirena.org.uk>
 <1451599146.9673.2.camel@collins>
Message-ID: <20151231221407.GF16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 31, 2015 at 10:59:06PM +0100, Paul Kocialkowski wrote:

> I understand, thanks for pointing this out. Well, for my use case, there
> is no use in disabling the chip at any point as it powers the external
> mmc.

Presumably someone might decide not to use the MMC in some case (perhaps
only mounting it when explicitly needed in order to save power for
example, or the MMC subsystem might figure out a way to power down an
idle MMC block device).

> Would you agree to have the enable pin handled directly (and by that, I
> mean enabled once, when requested, as I first suggested in the patchset)
> in the driver then?

That's probably fine, or do it via runtime PM (the framework is fairly
simple to use, I'll probably go add support in the core for it in the
next day or two as this seems like a sensible use case).  I can't
remember if this device is a MFD or not and I'm just on my way out the
door.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151231/90175a0c/attachment-0001.sig>
