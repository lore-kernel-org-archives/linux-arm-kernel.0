From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 06 Jun 2016 14:37:24 +0200
Subject: [RFC v2 4/4] ARM: keystone: dma-coherent with safe fallback
In-Reply-To: <20160606114256.GF6831@leverpostej>
References: <1465183229-24147-1-git-send-email-wmills@ti.com>
 <5480709.cGbSehIKrE@wuerfel> <20160606114256.GF6831@leverpostej>
Message-ID: <4810162.vDdHVxWF0U@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, June 6, 2016 12:42:56 PM CEST Mark Rutland wrote:
> On Mon, Jun 06, 2016 at 11:09:07AM +0200, Arnd Bergmann wrote:
> > On Monday, June 6, 2016 9:56:27 AM CEST Mark Rutland wrote:
> >
> > So far, the assumption has been:
> > 
> > - when running a non-LPAE kernel, keystone is not coherent, and we
> >   must ignore both the dma-coherent properties in devices and the
> >   dma-ranges properties in bus nodes.
> 
> I wasn't able to spot if/where that was enforced. Is it possible to boot
> Keystone UP, !LPAE?

With !LPAE, no devices are coherent, so that should work with both
SMP and and UP. Not sure about LPAE with coherent devices on UP,
IIRC we had a bug in that configuration on Armada XP, as the memory
was not marked as sharable at all there, and ended up not being
coherent with DMA masters.

My first guess is that uniprocessor mode on keystone has not been
tested at all (TI's QA seems to test only a very limited number of
configurations), so it may or may not work.

	Arnd
