From: davem@davemloft.net (David Miller)
Date: Thu, 17 May 2012 19:03:46 -0400 (EDT)
Subject: [PATCH V3] CS89x0 : Use ioread16/iowrite16 on all platforms
In-Reply-To: <1337274702-19536-1-git-send-email-jaccon.bastiaansen@gmail.com>
References: <1337274702-19536-1-git-send-email-jaccon.bastiaansen@gmail.com>
Message-ID: <20120517.190346.175685939436302276.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
Date: Thu, 17 May 2012 19:11:42 +0200

> The use of the inw/outw functions by the cs89x0 platform driver
> results in NULL pointer references on ARM platforms and
> platforms that do not provide ISA-style programmed I/O accessors.
> 
> Using inw/outw also accesses the wrong address space on platforms
> that have a PCI I/O space that is not identity-mapped into the
> physical address space.
> 
> Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>

I could nit-pick more on this patch, but it's such a significant
improvement I'm just going to apply this V3 as-is to net-next.

Thanks.
