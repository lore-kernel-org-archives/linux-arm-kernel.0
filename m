From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 30 Jan 2013 18:35:17 +0100
Subject: [PATCH] arm: mvebu: support for the new Armada XP evaluation
 board(DB-MV784MP-GP)
In-Reply-To: <20130130173306.GO7717@titan.lakedaemon.net>
References: <1359566774-27669-1-git-send-email-gregory.clement@free-electrons.com>
 <1359566774-27669-2-git-send-email-gregory.clement@free-electrons.com>
 <20130130173306.GO7717@titan.lakedaemon.net>
Message-ID: <510959D5.1010305@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2013 06:33 PM, Jason Cooper wrote:
> On Wed, Jan 30, 2013 at 06:26:14PM +0100, Gregory CLEMENT wrote:
>> This is the new Armada XP evaluation board from Marvell. It comes with
>> a RS232 port over USB, a SATA link, an internal SSD, 4 Ethernet
>> Gigabit links.
>>
>> Support for USB (Host and device), SDIO, PCIe will be added as drivers
>> when they become available for Armada XP in mainline.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  arch/arm/boot/dts/Makefile         |    1 +
>>  arch/arm/boot/dts/armada-xp-gp.dts |   94 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 95 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/armada-xp-gp.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 5ebb44f..51aab4b 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -78,6 +78,7 @@ dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
>>  dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
>>  	armada-370-mirabox.dtb \
>>  	armada-xp-db.dtb \
>> +	armada-xp-gp.dtb \
>>  	armada-xp-openblocks-ax3-4.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx51-babbage.dtb \
>>  	imx53-ard.dtb \
>> diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
>> new file mode 100644
>> index 0000000..85ba642
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/armada-xp-gp.dts
>> @@ -0,0 +1,94 @@
>> +/*
>> + * Device Tree file for Marvell Armada XP evaluation board
>> + * (RD-MV784MP-GP)
>> + *
>> + * Copyright (C) 2013 Marvell
>> + *
>> + * Lior Amsalem <alior@marvell.com>
>> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
>> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +/dts-v1/;
>> +/include/ "armada-xp-mv78460.dtsi"
>> +
>> +/ {
>> +	model = "Marvell Armada XP Evaluation Board: RD-MV784MP-GP";
>> +	compatible = "marvell,axp-db", "marvell,armadaxp-mv78460", "marvell,armadaxp", "marvell,armada-370-xp";
>> +
>> +	chosen {
>> +		bootargs = "console=ttyS0,115200 earlyprintk";
>> +	};
>> +
>> +	memory {
>> +		device_type = "memory";
>> +		reg = <0x00000000 0xC0000000>; /* 3 GB */
> 
> Is this the soldered on the board amount, or the amount with an
> expandable slot filled?

It is not soldered, so you can change the amount of memory

> 
> thx,
> 
> Jason.
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
