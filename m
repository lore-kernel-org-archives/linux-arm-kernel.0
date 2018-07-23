From: broonie@kernel.org (Mark Brown)
Date: Mon, 23 Jul 2018 19:11:50 +0100
Subject: next-20180723 build: 2 failures 11 warnings (next-20180723)
In-Reply-To: <E1fheAy-0003tU-Dq@optimist>
References: <E1fheAy-0003tU-Dq@optimist>
Message-ID: <20180723181150.GF13981@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 05:59:12PM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an arm64 allmodconfig with:

> 	arm64-allmodconfig
> ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!

using

   aarch64-linux-gnu-gcc (Linaro GCC 5.3-2016.05) 5.3.1 20160412

however it builds perfectly fine with

   aarch64-linux-gnu-gcc (Linaro GCC 6.2-2016.11) 6.2.1 20161016

which honestly seems like a sensible and worthwhile upgrade at this
point anyway given that it's a year and a half old so I'm going to do
that for my builder (perhaps even jump on a newer version) but it seemed
worth highlighting in case this is considered undesirable.  A similar
issue is hitting on KernelCI, we should probably look at upgrading the
toolchain there too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180723/f22badc9/attachment-0001.sig>
