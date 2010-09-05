From: michael.williamson@criticallink.com (Michael Williamson)
Date: Sun, 05 Sep 2010 08:02:52 -0400
Subject: [PATCH] davinci: Add I2C0 devices to MityDSP-L138/MityARM-1808
	platform
In-Reply-To: <4C837195.2040100@mvista.com>
References: <1283616701-6418-1-git-send-email-michael.williamson@criticallink.com>
	<4C837195.2040100@mvista.com>
Message-ID: <4C8386EC.50002@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/2010 06:31 AM, Sergei Shtylyov wrote:
> Hello.
> 
> On 04-09-2010 20:11, Michael Williamson wrote:
> 
>> This patch adds the i2c0 bus and attached devices to the MityDSP-L138
>> and MityARM-1808 davinci SoM.  Included is a TPS65023 voltage regulator
>> needed for power management and a small 24c02 EPROM that contains
>> factory configuration data.
> 
>> Signed-off-by: Michael Williamson<michael.williamson@criticallink.com>
> [...]
>> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c
>> b/arch/arm/mach-davinci/board-mityomapl138.c
>> index 7146916..03820ce 100644
>> --- a/arch/arm/mach-davinci/board-mityomapl138.c
>> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
> [...]
>> @@ -25,6 +27,141 @@
> [...]
>> +struct regulator_init_data tps65023_regulator_data[] = {
>> +    /* dcdc1 */
>> +    {
>> +        .constraints = {
>> +            .min_uV = 1150000,
>> +            .max_uV = 1350000,
>> +            .valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
>> +                REGULATOR_CHANGE_STATUS),
> 
>    Would look better if you aligned it. And parens are useless here.
> 

I'll clean it up, but I pretty much lifted it from board-da850-evm.c. 
The next time someone's in there, I suppose it should also be addressed.

Thanks for the comments.
