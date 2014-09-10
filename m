From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Sep 2014 10:17:14 +0200
Subject: [PATCH v5] spi: spi-imx: add DMA support
In-Reply-To: <1410312604-31949-1-git-send-email-b38343@freescale.com>
References: <1410312604-31949-1-git-send-email-b38343@freescale.com>
Message-ID: <5412055.BAOgFikuh9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 September 2014 09:30:04 Robin Gong wrote:
> Enable DMA support on i.mx6. The read speed can increase from 600KB/s
> to 1.2MB/s on i.mx6q. You can disable or enable dma function in dts.
> If not set "dma-names" in dts, spi will use PIO mode. This patch only
> validate on i.mx6, not i.mx5, but encourage ones to apply this patch
> on i.mx5 since they share the same IP.
> 
> Note:
>   Sometime, there is a weid data in rxfifo after one full tx/rx
> transfer finish by DMA on i.mx6dl, so we disable dma functhion on
> i.mx6dl.
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> Signed-off-by: Robin Gong <b38343@freescale.com>
> 
> 

The patch looks good to me, but you need to also update the
Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt file to
document the additional optional properties.

	Arnd
