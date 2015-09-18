From: alison.wang@freescale.com (Huan Wang)
Date: Fri, 18 Sep 2015 07:38:13 +0000
Subject: [PATCH v4] ARM: configs: Add Freescale LS1021A defconfig
In-Reply-To: <20150917103414.GN21084@n2100.arm.linux.org.uk>
References: <1442480614-32345-1-git-send-email-b18965@freescale.com>
 <20150917103414.GN21084@n2100.arm.linux.org.uk>
Message-ID: <BN3PR0301MB08674C65714A9423E39E1F10FE590@BN3PR0301MB0867.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, Sep 17, 2015 at 05:03:34PM +0800, Alison Wang wrote:
> > Add Freescale LS1021A initial defconfig file.
> > The LS1021A SoC is a dual-core Cortex-A7 based processor.
> >
> > LS1021A has some special configurations against imx_v6_v7_defconfig
> > and multi_v7_defconfig, such as CONFIG_ARM_LPAE, CONFIG_ARM_PSCI...
> > LPAE needs to be supported to access memory beyond the 4GB limit for
> > LS1021A. PSCI needs to be supported for LS1021A too. But
> > CONFIG_ARM_LPAE and CONFIG_ARM_PSCI are disabled in
> > imx_v6_v7_defconfig and multi_v7_defconfig, so a separate LS1021A
> defconfig is needed.
> 
> Sounds like a need for multi_v7_lpae_defconfig rather than creating a
> new load of platform specific defconfigs.
> 
[Alison Wang] Thanks for your reply. I agreed with you about creating
a new multi_v7_lpae_defconfig. In multi_v7_lpae_defconfig, I need to add
the following CONFIG_XX to support LS1021A based on multi_v7_defconfig.

CONFIG_ARM_LPAE=y
CONFIG_VMSPLIT_2G=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=256000
CONFIG_GIANFAR=y
CONFIG_REALTEK_PHY=y
CONFIG_I2C_IMX=y
CONFIG_SPI_FSL_DSPI=y
CONFIG_IMX2_WDT=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SOC=y
CONFIG_SND_SOC_FSL_SAI=y
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SIMPLE_CARD=y
CONFIG_FSL_EDMA=y
CONFIG_CLK_QORIQ=y

What's your suggestion? If it's ok, I will send a patch about multi_v7_lpae_defconfig.


Best Regards,
Alison Wang
