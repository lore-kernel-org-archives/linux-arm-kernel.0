From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 21:22:15 +0000
Subject: [PATCH V2] CS89x0 : Use ioread16/iowrite16 on all platforms
In-Reply-To: <1337112906-31033-1-git-send-email-jaccon.bastiaansen@gmail.com>
References: <1337112906-31033-1-git-send-email-jaccon.bastiaansen@gmail.com>
Message-ID: <201205152122.15840.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2012, Jaccon Bastiaansen wrote:
> 
> The use of the inw/outw functions by the cs89x0 platform driver
> results in NULL pointer references on ARM platforms and
> platforms that do not provide ISA-style programmed I/O accessors.
> 
> Using inw/outw also accesses the wrong address space on platforms
> that have a PCI I/O space that is not identity-mapped into the
> physical address space.
> 
> Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>

Looks good to me now.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Of course we would need some testing on another platform and ideally
also on an ISA based machine, although that might be hard to
come by these days...

	Arnd
