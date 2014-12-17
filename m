From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Wed, 17 Dec 2014 13:46:31 -0600
Subject: [PATCH 2/2] arm: socfpga: Set share override bit of the l2 cache
 controller
In-Reply-To: <2156186.zs80uXCLAf@wuerfel>
References: <1416546280-12068-1-git-send-email-dinguyen@opensource.altera.com>
 <1416546280-12068-2-git-send-email-dinguyen@opensource.altera.com>
 <2156186.zs80uXCLAf@wuerfel>
Message-ID: <5491DD97.6010303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 11/21/14, 5:04 AM, Arnd Bergmann wrote:
> On Thursday 20 November 2014 23:04:40 dinguyen at opensource.altera.com wrote:
>>
>> ---
>>  arch/arm/mach-socfpga/socfpga.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
>> index 13b1858..afc009f 100644
>> --- a/arch/arm/mach-socfpga/socfpga.c
>> +++ b/arch/arm/mach-socfpga/socfpga.c
>> @@ -105,7 +105,8 @@ static const char *altera_dt_match[] = {
>>  
>>  DT_MACHINE_START(SOCFPGA, "Altera SOCFPGA")
>>         .l2c_aux_val    = L310_AUX_CTRL_DATA_PREFETCH |
>> -                         L310_AUX_CTRL_INSTR_PREFETCH,
>> +                         L310_AUX_CTRL_INSTR_PREFETCH |
>> +                         L2C_AUX_CTRL_SHARED_OVERRIDE,
>>         .l2c_aux_mask   = ~0,
>>         .smp            = smp_ops(socfpga_smp_ops),
>>         .map_io         = socfpga_map_io,
> 
> Hi Dinh,
> 
> Please do this by putting the appropriate proterties into the
> l2x0 DT node instead.
> 

I don't see a way to do this using the l2x0 DT node.

Thanks,
Dinh
