From: broonie@kernel.org (Mark Brown)
Date: Fri, 22 Jul 2016 11:38:29 +0100
Subject: next-20160722 build: 1 failures 5 warnings (next-20160722)
In-Reply-To: <E1bQXSf-0008Uu-Ej@optimist>
References: <E1bQXSf-0008Uu-Ej@optimist>
Message-ID: <20160722103829.GY6509@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2016 at 11:13:41AM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an ARM allmodconfig due to:

> 	arm-allmodconfig
> ERROR: "dax_do_io" [fs/xfs/xfs.ko] undefined!

due to 16d4d43595b47 (xfs: split direct I/O and DAX path) which added an
unconditional reference to dax_do_io().  DAX is explicitly disabled on
32 bit ARM due to problems with virtual aliasing caches (it's not clear
to me that it shouldn't also be disabled for arm64 for the same reason).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160722/00350e08/attachment.sig>
