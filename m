From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 12 Apr 2012 14:02:06 +1000
Subject: linux-next: manual merge of the arm-soc tree with the mmc tree
Message-ID: <20120412140206.704731281bf2ee7d93d582bf@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/mmc/host/Kconfig between commit a334b9550294 ("mmc: remove imxmmc
driver") from the mmc tree and commits a21a92c0c787 ("mmc: Kconfig: remove
choice between at91_mci and atmel-mci") and 62080f06de6b ("mmc:
atmel-mci: remove the need for CONFIG_MMC_ATMELMCI_DMA") from the arm-soc
tree.

I fixed it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/mmc/host/Kconfig
index 9f1f5e2,4d15dff..0000000
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@@ -295,18 -288,16 +288,6 @@@ config MMC_ATMELMC
  
  	  If unsure, say N.
  
- endchoice
- 
- config MMC_ATMELMCI_DMA
- 	bool "Atmel MCI DMA support"
- 	depends on MMC_ATMELMCI && (AVR32 || ARCH_AT91SAM9G45) && DMA_ENGINE
- 	help
- 	  Say Y here to have the Atmel MCI driver use a DMA engine to
- 	  do data transfers and thus increase the throughput and
- 	  reduce the CPU utilization.
- 
- 	  If unsure, say N.
- 
 -config MMC_IMX
 -	tristate "Motorola i.MX Multimedia Card Interface support"
 -	depends on ARCH_MX1
 -	help
 -	  This selects the Motorola i.MX Multimedia card Interface.
 -	  If you have a i.MX platform with a Multimedia Card slot,
 -	  say Y or M here.
 -
 -	  If unsure, say N.
 -
  config MMC_MSM
  	tristate "Qualcomm SDCC Controller Support"
  	depends on MMC && ARCH_MSM
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120412/315ce2d8/attachment.sig>
