From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Fri, 14 Nov 2014 09:31:42 +0000
Subject: [PATCH] ARM: imx: temporarily remove CONFIG_SOC_FSL from LS1021A
In-Reply-To: <3302008.ezqrZf1odh@wuerfel>
References: <1414746073-12394-1-git-send-email-jingchang.lu@freescale.com>
 <1727581.y25NQPsRIm@wuerfel> <20141112104239.GJ2704@dragon>
 <3302008.ezqrZf1odh@wuerfel>
Message-ID: <7b9de442bdd34acbb4398efe92a64a4f@BN3PR0301MB1236.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Arnd Bergmann [mailto:arnd at arndb.de]
>Sent: Wednesday, November 12, 2014 7:05 PM
>To: linux-arm-kernel at lists.infradead.org
>Cc: Shawn Guo; mark.rutland at arm.com; devicetree at vger.kernel.org; Lu
>Jingchang-B35083
>Subject: Re: [PATCH] ARM: imx: temporarily remove CONFIG_SOC_FSL from
>LS1021A
>
>On Wednesday 12 November 2014 18:42:41 Shawn Guo wrote:
>>
>> I noticed the issue from 0-DAY testing and was trying to drop the patch.
>> Jingchang said someone is trying to fixing the issues from driver code.
>> But it seems to take some time.  So I agree with this partial reverting.
>>
>> Patch applied.  Thanks Arnd.
>
>Thanks a lot!
>
>Jingchang, can you say which of the drivers that are currently depending
>on FSL_SOC are reused on LS1021A? I see these ones in the source tree:
>
>drivers/ata/sata_fsl.c
>drivers/crypto/caam/
>drivers/crypto/talitos.c
>drivers/dma/fsldma.c
>drivers/memory/fsl_ifc.c
>drivers/misc/carma/
>drivers/mtd/nand/fsl_ifc_nand.c
>drivers/net/ethernet/freescale/fsl_pq_mdio.c
>drivers/net/ethernet/freescale/gianfar*
>drivers/net/ethernet/freescale/xgmac_mdio.c
>drivers/spi/spi-fsl-cpm.c
>drivers/spi/spi-fsl-dspi.c
>drivers/spi/spi-fsl-espi.c
>drivers/usb/host/ehci-fsl.c
>drivers/video/fbdev/fsl-diu-fb.c
>drivers/virt/fsl_hypervisor.c
>sound/soc/fsl/mpc*
>
>I suspect that you only want a small subset of these, but I have no idea
>which.
>
>	Arnd

Hi, Arnd and Shawn,

  Many thanks for your work on resolving the FSL_SOC breaking allmodconfig.

  Formerly many drivers on PPC depend on a FSL_SOC configuration, when they
are shared on our ARM platform, I add this configuration internally for
quick reference and also some internal developers' requirement, thus I
also add it into my upstream code.

 Yes, only a subset of these drivers are shared between our ARM and PPC
platforms. Since there will be allmodconfig breaking fault due to the
FSL_SOC configuration, we will try to fix this or select another dependency,
I will also inform our driver owners about this.
 
Below drivers are shared on LS1021A platform currently:

drivers/crypto/caam/
drivers/memory/fsl_ifc.c
drivers/mtd/nand/fsl_ifc_nand.c
drivers/net/ethernet/freescale/fsl_pq_mdio.c
drivers/net/ethernet/freescale/gianfar*
drivers/spi/spi-fsl-dspi.c


Thanks and Best Regards,
Jingchang
