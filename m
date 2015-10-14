From: fcooper@ti.com (Franklin S Cooper Jr.)
Date: Wed, 14 Oct 2015 08:08:59 -0500
Subject: [PATCH] ARM: DRA7: hwmod: Remove elm address space from hwmod data
In-Reply-To: <561DFD26.9090702@ti.com>
References: <1444743874-4454-1-git-send-email-fcooper@ti.com>
 <561DFD26.9090702@ti.com>
Message-ID: <561E53EB.9060207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/14/2015 01:58 AM, Roger Quadros wrote:
> On 13/10/15 16:44, Franklin S Cooper Jr wrote:
>> ELM address information is provided by device tree. No longer need
>> to include this information within hwmod.
>>
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> Acked-by: Roger Quadros <rogerq@ti.com>
>
> Franklin,
>
> Can you please do the same for gpmc_addr as well?
>
> And looks like elm_addr needs to be removed from
> omap_hwmod_33xx_43xx_interconnect_data.c and omap_hwmod_44xx_data.c as well, no?
Sure I'll combine the 335x and 44x elm removal with this patch and then create a separate patch for the gpmc version.
>
> cheers,
> -roger
>
>> ---
>>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 10 ----------
>>  1 file changed, 10 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> index 562247b..ad2cc7a 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> @@ -2566,21 +2566,11 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__hdmi = {
>>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>>  };
>>  
>> -static struct omap_hwmod_addr_space dra7xx_elm_addrs[] = {
>> -	{
>> -		.pa_start	= 0x48078000,
>> -		.pa_end		= 0x48078fff,
>> -		.flags		= ADDR_TYPE_RT
>> -	},
>> -	{ }
>> -};
>> -
>>  /* l4_per1 -> elm */
>>  static struct omap_hwmod_ocp_if dra7xx_l4_per1__elm = {
>>  	.master		= &dra7xx_l4_per1_hwmod,
>>  	.slave		= &dra7xx_elm_hwmod,
>>  	.clk		= "l3_iclk_div",
>> -	.addr		= dra7xx_elm_addrs,
>>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>>  };
>>  
>>
