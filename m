From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Wed, 15 Feb 2017 09:57:50 -0600
Subject: [PATCH] reset-socfpga: Fix nr_resets property
In-Reply-To: <1487170620.2433.43.camel@pengutronix.de>
References: <3302533.E0QKRXBlfc@pcimr>
 <1487170620.2433.43.camel@pengutronix.de>
Message-ID: <d9a873a0-8e71-840b-c54d-077a5ad77237@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/15/2017 08:57 AM, Philipp Zabel wrote:
> [Added Dinh to Cc:]
> 
> On Wed, 2017-02-15 at 14:06 +0100, Rojhalat Ibrahim wrote:
>> The SoC-FPGA reset controller driver defines NR_BANKS as 4 and uses that define
>> for two unrelated purposes. It is used
>> 1. as an increment for reset line banks which are 32-bit registers with 4-byte
>> aligned addresses.
>> 2. as the total number of reset line banks which together with the number of
>> resets per bank (32) limits the total number of useable resets to 96 and the
>> highest useable reset ID to 95.
>> This is clearly wrong as there are resets with higher IDs than 95 defined in
> 
> 128 and 127, respectively.
> 
>> include/dt-bindings/reset/altr,rst-mgr.h and altr,rst-mgr-a10.h.
>>
>> The patch introduces a new define BANK_INCREMENT for calculating the register
>> addresses as before and increases NR_BANKS to 6 for useable reset IDs up to 191.
> 
> Actually, looking at the Arria 10 TRM, it looks like there are
> mpumodrst, per0modrst, per1modrst, brgmodrst, sysmodrst, coldmodrst,
> nrstmodrst, and dbgmodrst registers on that SoC, which would mean
> NR_BANKS should be changed to 8. Dinh, what do you think?
> 

Yes, I agree. Should be 8. Thanks for the patch!

Dinh
