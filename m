From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Feb 2013 17:28:29 +0100
Subject: [PATCH 2/5] spi: pl022: use generic DMA slave configuration if
 possible
In-Reply-To: <20130208162248.GY17833@n2100.arm.linux.org.uk>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <3752726.iyKukyN6sF@wuerfel> <20130208162248.GY17833@n2100.arm.linux.org.uk>
Message-ID: <11938235.WbhQmuClDR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 February 2013 16:22:48 Russell King - ARM Linux wrote:
> If it's DMA _to_ a device, then we will only ever clean the lines prior to
> a transfer, never invalidate them.  So that's not really a concern.  (There
> better not be any dirty cache lines associated with the empty zero page
> either.)

Right, makes sense. I thought I had read about a CPU that
could not flush a cache line without also invalidating
it, but that must have been something other than ARM,
or maybe I'm misremembering it.

	Arnd
