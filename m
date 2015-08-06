From: broonie@kernel.org (Mark Brown)
Date: Thu, 6 Aug 2015 19:01:56 +0100
Subject: next-20150806 build: 2 failures 52 warnings (next-20150806)
In-Reply-To: <E1ZNIul-0007IF-Ev@optimist>
References: <E1ZNIul-0007IF-Ev@optimist>
Message-ID: <20150806180156.GC20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 12:00:47PM +0100, Build bot for Mark Brown wrote:

Today's linux-next fails to build an ARM allmodconfig with:

> ../drivers/iommu/omap-iommu-debug.c:138:2: error: void value not ignored as it ought to be

caused by a combination of 1ba2f20ac (fs/seq_file: convert int
seq_vprint/seq_printf/etc... returns to void) which made seq_printf()
return void and e203db293863fa15 (iommu/omap: Fix debug_read_tlb() to
use seq_printf()) which has been in -next for a little while now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150806/41897b91/attachment.sig>
