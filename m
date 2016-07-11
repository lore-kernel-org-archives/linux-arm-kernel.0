From: broonie@kernel.org (Mark Brown)
Date: Mon, 11 Jul 2016 19:31:13 +0100
Subject: next-20160711 build: 3 failures 10 warnings (next-20160711)
In-Reply-To: <E1bMZki-0001u7-VI@optimist>
References: <E1bMZki-0001u7-VI@optimist>
Message-ID: <20160711183113.GH3701@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 12:51:57PM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build on all arm64 configs with:

> ../arch/arm64/include/asm/vdso.h:30:36: fatal error: generated/vdso-offsets.h: No such file or directory
> ../arch/arm64/include/asm/vdso.h:30:36: fatal error: generated/vdso-offsets.h: No such file or directory

due to 90f777beb788 (arm64: Fix vdso-offsets.h dependency) when built
from a completely clean tree (eg, after make distconfig).  Building from
a non-clean environment does work, as does reverting that commit.  The
dependencies required to ensure that the header gets generated before
it's used aren't present so make doesn't figure out the ordering
correctly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160711/4e8b10ba/attachment-0001.sig>
