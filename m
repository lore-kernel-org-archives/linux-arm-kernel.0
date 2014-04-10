From: monstr@monstr.eu (Michal Simek)
Date: Thu, 10 Apr 2014 08:01:36 +0200
Subject: [RFC PATCH v2] edac: synopsys: Added EDAC support for zynq ddr
 ecc controller
In-Reply-To: <20140408204047.GQ30077@pd.tnic>
References: <1220b715-6fc2-42ed-8393-b9859fc0deb9@TX2EHSMHS021.ehs.local>
 <20140408204047.GQ30077@pd.tnic>
Message-ID: <534633C0.9090905@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav and Punnaiah,

some comments below.

>> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
>> new file mode 100644
>> index 0000000..7cec331
>> --- /dev/null
>> +++ b/drivers/edac/synopsys_edac.c
>> @@ -0,0 +1,614 @@
>> +/*
>> + * Synopsys DDR ECC Driver
>> + * This driver is based on ppc4xx_edac.c drivers
>> + *
>> + * Copyright (C) 2012 - 2014 Xilinx, Inc.
> 
> The same question to you: are you going to maintain this driver? If so,
> please consider adding yourself to the MAINTAINERS file so that people
> reporting issues with it can send you a note.

Just add it to Zynq maintainer fragment as we are doing for non zynq/xilinx
drivers.


>> +/**
>> + * struct synopsys_edac_priv - DDR memory controller private instance data
>> + * @baseaddr:		Base address of the DDR controller
>> + * @ce_count:		Correctable Error count
>> + * @ue_count:		Uncorrectable Error count
>> + */
>> +struct synopsys_edac_priv {
>> +	void __iomem *baseaddr;
>> +	u32 ce_count;
>> +	u32 ue_count;
>> +};
>> +
>> +/**
> 
> Why do we need the kernel-doc annotation for all those static functions?

I don't want to fight on this but having documentation help with reading
the code. I also don't think that only non static functions are documented.
I can't see any problem to have kernel-doc for static functions.
At least the is the first time when someone saying that only some functions
should be documented.


> Also, drop the "synopsys_edac_" prefix of all static functions - that'll
> slim up the code even further.

I don't think this is good to do. When we remove this prefix entirely
it is bigger chance that the same function name will be used by another driver.
It is not a problem with linking but the same functions names will be listed
in System.map which will complicate debugging.
For ARM multiplatform kernel I think that it is almost must to use
vendor prefixes for all platform/driver code.
All drivers can use instead of name_probe just probe but I don't think
this is the right way to go.

The rest was commented by Punnaiah.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140410/7a6702b1/attachment.sig>
