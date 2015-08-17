From: broonie@kernel.org (Mark Brown)
Date: Sun, 16 Aug 2015 20:30:47 -0700
Subject: [PATCH] spi: Mediatek: fix endian warnings
In-Reply-To: <20150816140639.GE7557@n2100.arm.linux.org.uk>
References: <1439289789-29026-1-git-send-email-leilk.liu@mediatek.com>
 <1871097.B3YgX5rNy0@wuerfel>
 <20150816140639.GE7557@n2100.arm.linux.org.uk>
Message-ID: <20150817033047.GM10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 16, 2015 at 03:06:39PM +0100, Russell King - ARM Linux wrote:

> All writel() implementations take a CPU number and write it in little
> endian format.  Hence, writel() almost always uses cpu_to_le32()
> internally.

I think the reason this keeps coming up is that people aren't expecting
writel() to be doing endianness conversion, it's easy to get caught out
by it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150816/42f0fde6/attachment.sig>
