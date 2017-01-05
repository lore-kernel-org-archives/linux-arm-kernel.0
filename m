From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 Jan 2017 19:55:46 +0000
Subject: next-20170105 build: 4 failures 3 warnings (next-20170105)
In-Reply-To: <E1cP6p1-0007i0-IF@optimist>
References: <E1cP6p1-0007i0-IF@optimist>
Message-ID: <20170105195546.wnmjwh4hazqiyodf@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 12:07:08PM +0000, Build bot for Mark Brown wrote:

Since sometime over the Christmas vacation all arm64 configs have been
failing to build due to:

> ../arch/arm64/include/asm/setup.h:14:29: error: redefinition of 'kaslr_offset'

(same error repeating a different number of times for each config).
This is an interaction between Andrew's -current tree and Linus' tree.
Andrew's tree has "arm64: setup: introduce kaslr_offset()"
(1a339a14b1f2c7 in current -next) and Linus' tree has a commit
7ede8665f27cde7d with the same title but a modified version that went to
Linus through Will.  In the version in Andrew's tree kaslr_offset() is
defined in asm/setup.h while in the version in Linus' tree it is
instead defined in asm/memory.h so -next ends up with two definitions of
that function causing the build errors.

I guess the commit in Andrew's tree should be dropped now, reverting it
fixes the builds for me.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170105/c7933fea/attachment.sig>
