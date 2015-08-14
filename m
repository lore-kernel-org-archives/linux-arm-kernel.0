From: horia.geanta@freescale.com (=?UTF-8?Q?Horia_Geant=c4=83?=)
Date: Fri, 14 Aug 2015 20:06:06 +0300
Subject: [PATCH v3] ARM: configs: Add Freescale LS1021A defconfig
In-Reply-To: <55CB4829.40204@freescale.com>
References: <1438941784-38403-1-git-send-email-b18965@freescale.com>
 <55CB4829.40204@freescale.com>
Message-ID: <55CE1FFE.2080200@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/12/2015 4:20 PM, Horia Geant? wrote:
> On 8/7/2015 1:03 PM, Alison Wang wrote:
>> Add Freescale LS1021A initial defconfig file.
>> The LS1021A SoC is a dual-core Cortex-A7 based processor.
>>
>> LS1021A has some special configure options against common V7 SOCs,
>> such as CONFIG_THUMB2_KERNEL, CONFIG_VMSPLIT_2G, CONFIG_VFP...
>>
>> Enable I2C, LPUART, eDMA, WDT, GIANFAR, Sound, DSPI at default.
>>
>> Signed-off-by: Haikun Wang <haikun.wang@freescale.com>
>> Signed-off-by: Alison Wang <alison.wang@freescale.com>
>> ---
>> Changes since v2:
>> - Enable PSCI, as PSCI is enabled in u-boot.
>> Changes since v1:
>> - Enable GIANFAR, Sound and DSPI.
> 
> Looks like CONFIG_ARCH_DMA_ADDR_T_64BIT=y is missing.
> For e.g. CAAM (crypto engine) is a DMA device able to use 40-bit bus
> addresses.
> Note that ARCH_DMA_ADDR_T_64BIT does not depend / is not selected by
> ARM_LPAE.

Another thing:
Commit 385c0fb0e2c4 ("ARM: imx_v6_v7_defconfig: Select LS1021A") added
CONFIG_SOC_LS1021A in imx_v6_v7_defconfig.

Besides this, booting a LS1021 AQDS board (Rev2) using
imx_v6_v7_defconfig did not work (stuck at "Starting kernel").

Horia
