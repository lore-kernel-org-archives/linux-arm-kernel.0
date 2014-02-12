From: monstr@monstr.eu (Michal Simek)
Date: Wed, 12 Feb 2014 09:13:23 +0100
Subject: [PATCH v2 07/11] watchdog: xilinx: Use of_property_read_u32
In-Reply-To: <20140211202038.GC11798@roeck-us.net>
References: <f298edd222c57b0ce1ebad3ae50c3f715406c631.1392101734.git.michal.simek@xilinx.com>
 <7aa6e41032ebad0ffb2e1df20beb4f00e38d29e2.1392101734.git.michal.simek@xilinx.com>
 <20140211202038.GC11798@roeck-us.net>
Message-ID: <52FB2D23.7090200@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2014 09:20 PM, Guenter Roeck wrote:
> On Tue, Feb 11, 2014 at 07:55:50AM +0100, Michal Simek wrote:
>> Use of_property_read_u32 functions to clean probe function.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
> [ ... ]
> 
>> +
>> +	if (enable_once)
>>  		watchdog_set_nowayout(xilinx_wdt_wdd, true);
>> -	}
> 
> 	watchdog_set_nowayout(xilinx_wdt_wdd, enable_once);
> 
> would probably do as well (the function checks the flag as well).
> 
> Nitpick, so
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

I will change it and send v3.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/379eaea2/attachment.sig>
