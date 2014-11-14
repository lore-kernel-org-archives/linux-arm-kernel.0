From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Nov 2014 11:56:35 +0100
Subject: [PATCH] ARM: imx: temporarily remove CONFIG_SOC_FSL from LS1021A
In-Reply-To: <7b9de442bdd34acbb4398efe92a64a4f@BN3PR0301MB1236.namprd03.prod.outlook.com>
References: <1414746073-12394-1-git-send-email-jingchang.lu@freescale.com>
 <3302008.ezqrZf1odh@wuerfel>
 <7b9de442bdd34acbb4398efe92a64a4f@BN3PR0301MB1236.namprd03.prod.outlook.com>
Message-ID: <3531768.l2njma3NbB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 November 2014 09:31:42 Jingchang Lu wrote:
>  Yes, only a subset of these drivers are shared between our ARM and PPC
> platforms. Since there will be allmodconfig breaking fault due to the
> FSL_SOC configuration, we will try to fix this or select another dependency,
> I will also inform our driver owners about this.
>  
> Below drivers are shared on LS1021A platform currently:
> 
> drivers/crypto/caam/
> drivers/memory/fsl_ifc.c
> drivers/mtd/nand/fsl_ifc_nand.c
> drivers/net/ethernet/freescale/fsl_pq_mdio.c
> drivers/net/ethernet/freescale/gianfar*
> drivers/spi/spi-fsl-dspi.c

Ok, since this is only a small subset of the FSL_SOC drivers, I'd
suggest you make these depend on (FSL_SOC || ARCH_IMX) after
verifying that they build without warnings on ARM.

	Arnd
