From: cyril@ti.com (Cyril Chemparathy)
Date: Wed, 1 Aug 2012 11:41:08 -0400
Subject: [RFC 20/22] ARM: keystone: introducing TI Keystone platform
In-Reply-To: <201207312316.19592.arnd@arndb.de>
References: <1343775898-28345-1-git-send-email-cyril@ti.com>
 <1343775898-28345-21-git-send-email-cyril@ti.com>
 <201207312316.19592.arnd@arndb.de>
Message-ID: <50194E14.4070301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/31/2012 7:16 PM, Arnd Bergmann wrote:
> On Tuesday 31 July 2012, Cyril Chemparathy wrote:
>> Texas Instruments Keystone family of multicore devices now includes an
>> upcoming slew of Cortex A15 based devices.  This patch adds basic definitions
>> for a new Keystone sub-architecture in ARM.
>>
>> Subsequent patches in this series will extend support to include SMP and take
>> advantage of the large physical memory addressing capabilities via LPAE.
>>
>> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
>> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>

Thanks for taking a look, Arnd.

Any inputs on the other patches in this series?  I'd ideally like to 
have the LPAE fixes, and code patching changes merged in sooner than the 
Keystone machine specific stuff.

> And some nitpicking:
>> +
>> +	chosen {
>> +		bootargs = "console=ttyS0,115200n8 debug earlyprintk lpj=50000 rdinit=/bin/ash rw root=/dev/ram0 initrd=0x85000000,9M";
>> +	};
>
> This command line should not really be here. Most of what you put in it is not
> generic to the platform at all.
>
> In order to select the console, use an alias for the serial device.
>

Agreed.  The DTS in general needs quite a bit of work.

>> +
>> +static void __init keystone_map_io(void)
>> +{
>> +	iotable_init(io_desc, sizeof(io_desc)/sizeof(struct map_desc));
>> +}
>
> Use the ARRAY_SIZE macro here.
>

Thanks.  I've fixed this in the code, and this will show up in the next rev.

> 	Arnd
>

-- 
Thanks
- Cyril
