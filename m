From: daniel@zonque.org (Daniel Mack)
Date: Fri, 18 May 2018 23:31:02 +0200
Subject: [PATCH 05/15] mtd: nand: pxa3xx: remove the dmaengine compat need
In-Reply-To: <20180402142656.26815-6-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-6-robert.jarzmik@free.fr>
Message-ID: <a09d80dc-e8fd-1e9a-1878-8875ddc83134@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

Thanks for this series.

On Monday, April 02, 2018 04:26 PM, Robert Jarzmik wrote:
> From: Robert Jarzmik <robert.jarzmik@renault.com>
> 
> As the pxa architecture switched towards the dmaengine slave map, the
> old compatibility mechanism to acquire the dma requestor line number and
> priority are not needed anymore.
> 
> This patch simplifies the dma resource acquisition, using the more
> generic function dma_request_slave_channel().
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>   drivers/mtd/nand/pxa3xx_nand.c | 10 +---------

This driver was replaced by drivers/mtd/nand/raw/marvell_nand.c 
recently, so this patch can be dropped. I attached a version for the new 
driver which you can pick instead.


Thanks,
Daniel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-mtd-rawnand-marvell-remove-dmaengine-compat-code.patch
Type: text/x-patch
Size: 1633 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180518/23dc3757/attachment.bin>
