From: anurupvasu@gmail.com (Anurup M)
Date: Wed, 9 Nov 2016 16:14:40 +0530
Subject: [PATCH v1 03/11] drivers: soc: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <1609380.NN50qvVsP7@wuerfel>
References: <1478101374-18778-1-git-send-email-anurup.m@huawei.com>
 <2030692.HPgjBCTYG6@wuerfel>
 <2bac1a34-591b-6557-15bf-40db25c3d129@huawei.com>
 <1609380.NN50qvVsP7@wuerfel>
Message-ID: <5822FE18.5000901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 08 November 2016 08:40 PM, Arnd Bergmann wrote:
> On Tuesday, November 8, 2016 1:49:43 PM CET John Garry wrote:
>> Hi Arnd,
>>
>> Thanks for the reference.
>>
>> I think the i2c interface doesn't fully satisfy our requirements as we
>> need more than just a slave bus address when accessing the slave device
>> (which I think is what i2c uses). We also need to pass "offset" and
>> "mod_mask" arguments to the djtag adapter to access specific registers
>> in the slave device.
> Ok. Are those values constant per device, or maybe a range? We may want to
> include those in the reg property as well then.
>
> 	Arnd
>
Hi Arnd,

The "mod_mask" is to select the sub-module within a module. This 
parameter is
used for djtag write operation.
In the case of L3 cache, this will select the L3 cache bank. 0xFFFF 
select all banks.
This value will  change based on the L3 cache bank to be written to. I 
think this value
can be in the driver itself.

For djtag read operation, the "mod_mask" is ignored. instead the input 
parameter
"chain_id" is used. this will identify the sub-module or bank.

For djtag-v1, the "chain_id" is different for each L3 cache bank, But in 
the case of
djtag-v2 the "chain_id" is fixed and the value is 0 as In djtag-v2 there 
is separate
"module-id" for each sub-module.

The "offset" is the register offset and this value is a range for a module.

Thanks,
Anurup
