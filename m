From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 7 Aug 2013 14:46:13 -0300
Subject: [PATCH 01/20] mtd: pxa3xx-nand: replace pxa_request_dma with
 dmaengine
In-Reply-To: <1375889649-14638-2-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-2-git-send-email-zonque@gmail.com>
Message-ID: <20130807174612.GB18567@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Wed, Aug 07, 2013 at 05:33:50PM +0200, Daniel Mack wrote:
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> 
> [zonque at gmail.com: rebased in top of l2-mtd.git. The newly introduced
> ARCH_HAS_DMA hack was changed into a check for CONFIG_HAS_DMA]
> 

Are you sure you need to introduce the CONFIG_HAS_DMA ifdef?

The reason I introduced the ARCH_HAS_DMA macro was to avoid including
the "mach/dma.h" header. Now that you've removed it, I don't think
this driver can be used in any platform where CONFIG_HAS_DMA=n.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
