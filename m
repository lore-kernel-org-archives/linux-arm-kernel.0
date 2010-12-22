From: michael.williamson@criticallink.com (Michael Williamson)
Date: Wed, 22 Dec 2010 14:24:21 -0500
Subject: [PATCH] davinci: Support various speedgrades for MityDSP-L138
	and MityARM-1808 SoMs
In-Reply-To: <4D124ECE.8030900@mvista.com>
References: <1293039999-20239-1-git-send-email-michael.williamson@criticallink.com>
	<4D124ECE.8030900@mvista.com>
Message-ID: <4D125065.3020606@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/2010 2:17 PM, Sergei Shtylyov wrote:

> Hello.
> 
> Michael Williamson wrote:
> 
>> For the MityDSP-L138/MityARM-1808 SoMs, the speed grade can be determined
>> from the part number string read from the factory configuration block on
>> the on-board I2C PROM.  Configure the maximum CPU speed based on this
>> information.
> 
>> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
> [...]
> 
>> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
>> index 0bb5f0c..9d30c01 100644
>> --- a/arch/arm/mach-davinci/board-mityomapl138.c
>> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
>> @@ -44,38 +44,102 @@ struct factory_config {
>>  
>>  static struct factory_config factory_config;
>>  
>> +struct part_no_info {
>> +    const char    *part_no;  /* part number string of interest */
>> +    int        max_freq; /* khz */
> 
>    Why not align the comments (and do it with a tab)?
> 
> WBR, Sergei


I'd be happy to.  Thanks for the comment.
