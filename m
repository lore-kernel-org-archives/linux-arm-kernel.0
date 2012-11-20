From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 20 Nov 2012 17:09:10 +0200
Subject: [PATCH 0/5] OMAPFB: use dma_alloc instead of omap's vram
In-Reply-To: <20121119220443.GD18567@atomide.com>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
 <20121112225037.GU6801@atomide.com> <50A601FA.5060401@ti.com>
 <20121119220443.GD18567@atomide.com>
Message-ID: <50AB9D16.3010309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-20 00:04, Tony Lindgren wrote:

>> Should we enable CMA by default in omap2plus_defconfig? And perhaps on
>> omap1 also?
> 
> Yes if that's now needed for DSS.

DSS works fine without CMA, at least for small displays, and when fb
allocation is done at boot time. So it's not a strict "need".

I'm not sure how easily FB allocations start to fail without CMA, and
how much CMA helps.

I'm not even sure what's the default DMA pool size on OMAP... If it's
the one set with "coherent_pool" kernel parameter, then the default
seems to be 256K, which is quite small for video use. For CMA the
default global area is 16M. Both can, of course, be changed with boot
params or kernel config (at least for CMA).

But I think it makes sense to have CMA by default even if non-CMA kernel
would work.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 897 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121120/85fa6eaa/attachment.sig>
