From: broonie@kernel.org (Mark Brown)
Date: Mon, 23 Jul 2018 19:25:03 +0100
Subject: next-20180723 build: 2 failures 11 warnings (next-20180723)
In-Reply-To: <E1fheAy-0003tU-Dq@optimist>
References: <E1fheAy-0003tU-Dq@optimist>
Message-ID: <20180723182503.GH13981@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 05:59:12PM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an arm allnoconfig (and a bunch of other
arm configs from the look of some of the other builder reports) with:

> 	arm-allnoconfig
> ../mm/vmacache.c:14:39: error: 'PMD_SHIFT' undeclared (first use in this function)
> ../mm/vmacache.c:14:39: error: 'PMD_SHIFT' undeclared (first use in this function)
> ../mm/vmacache.c:127:26: error: 'addr' undeclared (first use in this function)
> ../mm/vmacache.c:14:39: error: 'PMD_SHIFT' undeclared (first use in this function)

due to 5d2f33872046e (mm, vmacache: hash addresses based on pmd) which
uses PMD_SHIFT rather than PAGE_SHIFT for VMACACHE_HASH() but that's not
defined in at least !MMU arm configs.  There is a reference to it in
arm/pgtable-nommu.h but only in comments with FIXMEs next to them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180723/3421abd5/attachment.sig>
