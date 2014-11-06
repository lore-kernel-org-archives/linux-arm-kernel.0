From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 6 Nov 2014 15:26:33 +0100
Subject: [PATCH v5 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <20141103103528.GA30154@gondor.apana.org.au>
References: <20141021191149.GQ21108@lukather> <544A9FEA.6020304@gmail.com>
 <20141030171933.GR21251@lukather>
 <20141031072030.GA7563@gondor.apana.org.au>
 <20141031081323.GS21251@lukather>
 <20141031081803.GA8012@gondor.apana.org.au>
 <20141031095706.GA8054@lukather>
 <20141031100522.GA8655@gondor.apana.org.au>
 <20141103093446.GG11263@lukather>
 <20141103103528.GA30154@gondor.apana.org.au>
Message-ID: <20141106142633.GK2989@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 03, 2014 at 06:35:28PM +0800, Herbert Xu wrote:
> On Mon, Nov 03, 2014 at 10:34:46AM +0100, Maxime Ripard wrote:
> > What I mean is that since you are saying that drivers should do the
> > kmap themselves, then *all* of the drivers are broken if they are not
> > using it. And all of them are missing this kmap.
> 
> kmap is used by the software implementations to map the input/output
> into virtual address space.  Drivers typically use DMA and operate
> on physical addresses so they don't need kmap.

Yes, plus all memory allocated with GFP_KERNEL is in lowmem.

But you still haven't explain why the driver, while it doesn't handle
the user space buffer at any time, should be worried that the data the
framework has given him are actually mapped.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/ae0d74ae/attachment-0001.sig>
