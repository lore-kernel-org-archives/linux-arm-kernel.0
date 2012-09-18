From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 18 Sep 2012 16:37:41 +0900
Subject: [PATCH 19/24] sh: use __iomem pointers for MMIO
In-Reply-To: <1347658492-11608-20-git-send-email-arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-20-git-send-email-arnd@arndb.de>
Message-ID: <20120918073741.GN13568@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 11:34:47PM +0200, Arnd Bergmann wrote:
> ARM is moving to stricter checks on readl/write functions,
> so we need to use the correct types everywhere.
> 
> I'm not completely sure about this patch, and it will
> probably require some arch/sh changes to go along with it,
> but it's clear that something has to be done to avoid
> getting hundreds of new warnings on each shmobile build
> in v3.7.
> Please see this as a prototype.
> 
I have no intention of making this change for arch/sh.

The __raw variants already accept both __iomem pointers and integer
addresses, which was largely intentional. New code could use the __iomem
annotations while older code could continue to use the integer addresses
without issue. If you wish to go through the kernel and audit every
single __raw user, you're certainly welcome to, but until then such a
change is premature.
