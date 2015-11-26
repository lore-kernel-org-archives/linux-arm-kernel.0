From: broonie@kernel.org (Mark Brown)
Date: Thu, 26 Nov 2015 11:32:13 +0000
Subject: next-20151126 build: 3 failures 15 warnings (next-20151126)
In-Reply-To: <E1a1sVV-00079q-My@optimist>
References: <E1a1sVV-00079q-My@optimist>
Message-ID: <20151126113213.GC1929@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 09:06:25AM +0000, Build bot for Mark Brown wrote:

Today's -next fails to build an arm64 allnoconfig due to:

> 	arm64-allnoconfig
> ../arch/arm64/mm/mmap.c:55:49: error: 'mmap_rnd_compat_bits' undeclared (first use in this function)

which was introduced by a combination of 8f62c06c279a3 (mm: mmap: add
new /proc tunable for mmap_base ASLR) and 9411708692954 (arm64: mm:
support ARCH_MMAP_RND_BITS).  These add an unconditional use of
mmap_rnd_compat_bits which is only defined in linux/mmap.h if
HAVE_ARCH_MMAP_RND_COMPAT_BITS is selected but that is only enabled for
arm64 if COMPAT is enabled.  Either the select needs to be unconditional
or the use needs to be.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151126/74d1d735/attachment.sig>
