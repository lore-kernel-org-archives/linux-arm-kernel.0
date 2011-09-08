From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Sep 2011 18:03:39 +0200
Subject: [RFC PATCH 06/10] hwspinlock: OMAP4: Add spinlock support in DT
In-Reply-To: <4E68E09B.4050006@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<201109081647.55377.arnd@arndb.de> <4E68E09B.4050006@ti.com>
Message-ID: <201109081803.40328.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 September 2011, Cousson, Benoit wrote:
> OK, this is indeed much more aligned with the current practice, and what 
> DMA should do as well.
> 
> Practically speaking, that change will go beyond the original scope of 
> that patch that was just adding the DT support based on the existing 
> functionality.
> 
> Is it OK to handle that improvement in a further patch / series?

I think we should be very careful to get the device tree syntax right
at first. So if you have a good representation of the data in the device
tree but don't handle all possible cases in the kernel yet, that's ok.

E.g. the kernel code can assume for now that the device tree has only
one spinlock controller node. We can fix that later when we actually
need more, but we would not easily be able to fix the device trees
after the fact.

	Arnd
