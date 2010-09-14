From: saeed@marvell.com (Saeed Bishara)
Date: Tue, 14 Sep 2010 10:48:52 +0300
Subject: dove: fix __io() definition to use bus based offset
In-Reply-To: <AANLkTim+u9qqTaGwzHKGfD+3nGammQDNWG6BoKkwfg2F@mail.gmail.com>
References: <AANLkTim+u9qqTaGwzHKGfD+3nGammQDNWG6BoKkwfg2F@mail.gmail.com>
Message-ID: <FCBE654890C0334289D0AD3AF4EF009FD18EE745FA@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

>-----Original Message-----
From: eric.y.miao@gmail.com [mailto:eric.y.miao at gmail.com] On 
>Behalf Of Eric Miao
>Sent: Tuesday, September 14, 2010 10:14 AM
>To: linux-arm-kernel
>Cc: Saeed Bishara; Nicolas Pitre
>Subject: ARM: dove: fix __io() definition to use bus based offset
>
>commit 821049d2bab27613f5f18639cf231e1c2230e5a9
>Author: Eric Miao <eric.y.miao@gmail.com>
>Date:   Tue Sep 14 16:06:22 2010 +0800
>
>    ARM: dove: fix __io() definition to use bus based offset
>
>    Signed-off-by: Eric Miao <eric.miao@canonical.com>
>
>This was proposed month ago, and had some other discussions about
>typesafe_io() and type casting. I hereby simplified the patch to its
>minimum and let's address the real issue first.
>
>Saeed, Acked?
Yes, The patch is ok for me.
>
>
>diff --git a/arch/arm/mach-dove/include/mach/io.h
>b/arch/arm/mach-dove/include/mach/io.h
>index 3b3e472..eb4936f 100644
>--- a/arch/arm/mach-dove/include/mach/io.h
>+++ b/arch/arm/mach-dove/include/mach/io.h
>@@ -13,8 +13,8 @@
>
> #define IO_SPACE_LIMIT		0xffffffff
>
>-#define __io(a)  ((void __iomem *)(((a) - DOVE_PCIE0_IO_PHYS_BASE) +\
>-				   DOVE_PCIE0_IO_VIRT_BASE))
>-#define __mem_pci(a)		(a)
>+#define __io(a)  	((void __iomem *)(((a) - 
>DOVE_PCIE0_IO_BUS_BASE) + \
>+						 
>DOVE_PCIE0_IO_VIRT_BASE))
>+#define __mem_pci(a)	(a)
>
> #endif
>
