From: jose.ferreiro@horus.es (jose)
Date: Thu, 29 Jan 2015 13:38:05 +0100
Subject: MX6Q Linux 3.10.17 Trying to read registers at boot time
Message-ID: <54CA29AD.2070703@horus.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

As you can see below, I came here redirected from:

https://community.freescale.com/message/473511#473511
and
meta-freescale at yoctoproject.org mail list

I am trying to read/write registers on a 3.10.17 linux compiled for 
Freescale iMX6Q. And I am trying to do it at mach-imx6q.c

Kernel hangs at Starting kernel point when I try the read.

Next step is try to access like IPU driver with 
platform_get_resource(pdev, IORESOURCE_MEM, 0) but if someone has any 
better suggestion I gladly will follow it.

Thanks and best regards,
Jose

----------------
I am not able to redirect the other list post so this is what I tried:
1) direct access
u32 reg = (ANADIG_ANA_MISC1_LVDSCLK1_IBEN | 
ANADIG_ANA_MISC1_LVDS1_CLK_SEL_MASK);

   writel(reg, (volatile void __iomem *) 0x20C8168);
2) map a region:
I used the request_mem_region, ioremap and ioread32 process 
(http://www.makelinux.net/ldd3/chp-9-sect-4)
