From: s.peter@mpl.ch (Stefan Peter)
Date: Wed, 16 Jan 2013 12:44:09 +0100
Subject: [PATCH 3/4] Enable ecc-mode selection in the driver
In-Reply-To: <20130115123307.GA13433@titan.lakedaemon.net>
References: <cover.1358242644.git.s.peter@mpl.ch>
 <2d08c4c072fd4922a6056362adb96a455307d583.1358242644.git.s.peter@mpl.ch>
 <20130115123307.GA13433@titan.lakedaemon.net>
Message-ID: <50F69289.8060401@mpl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason

on 15.01.2013 13:33, Jason Cooper wrote:
> Stefan,
> 
> This is a good-looking patch series, nice and small!  A few comments:
> 
> On Tue, Jan 15, 2013 at 01:13:12PM +0100, Stefan Peter wrote:
>> In order to be able to use the ecc-mode, add the bch module to the default
>> settings for the kirwood boards and enable the activation in orin-nand.c
> 
> s/orin-nand/orion-nand/

Will fix.

> 
>>
>> Signed-off-by: Stefan Peter <s.peter@mpl.ch>
>> ---
>> diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
>> index 93f3794..4a9d3f7 100644
>> --- a/arch/arm/configs/kirkwood_defconfig
>> +++ b/arch/arm/configs/kirkwood_defconfig
>> @@ -84,6 +84,7 @@ CONFIG_MTD_CFI_STAA=y
>>  CONFIG_MTD_PHYSMAP=y
>>  CONFIG_MTD_M25P80=y
>>  CONFIG_MTD_NAND=y
>> +CONFIG_MTD_NAND_ECC_BCH=y
>>  CONFIG_MTD_NAND_ORION=y
>>  CONFIG_BLK_DEV_LOOP=y
>>  # CONFIG_SCSI_PROC_FS is not set
> 
> Please make the defconfig change a separate patch.

Will do.

> 
> As a general note (this series shouldn't be a problem), please sort the
> series so that you add the driver feature first, then enable it in
> defconfig, then use it in DT.  This way, a future bisection won't run
> into any nasty surprises, other than what they're looking for. ;-)

Will do.

Thank you very much for your review.

Stefan Peter
-- 
MPL AG, Switzerland                     http://www.mpl.ch
Tel. +41 (0)56 483 34 34          Fax: +41(0)56 493 30 20
