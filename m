From: michael.williamson@criticallink.com (Michael Williamson)
Date: Wed, 02 Feb 2011 07:56:22 -0500
Subject: [PATCH v1 1/4] davinci: da8xx/omap-l1: add support for SPI
In-Reply-To: <4D4953D4.7080204@mvista.com>
References: <1296596979-18524-1-git-send-email-michael.williamson@criticallink.com>
	<1296596979-18524-2-git-send-email-michael.williamson@criticallink.com>
	<4D4953D4.7080204@mvista.com>
Message-ID: <4D495476.1040002@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/2/2011 7:53 AM, Sergei Shtylyov wrote:

> Hello.
> 
> On 02-02-2011 0:49, Michael Williamson wrote:
> 
>> Add SPI registration routines, clocks, and driver resources for
>> DA850/OMAP-L138/AM18x and DA830/OMAP-L137/AM17x platforms.
> 
>> Signed-off-by: Michael Williamson<michael.williamson@criticallink.com>
> [...]
> 
>> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
>> index beda8a4..f421f97 100644
>> --- a/arch/arm/mach-davinci/devices-da8xx.c
>> +++ b/arch/arm/mach-davinci/devices-da8xx.c
>> @@ -725,3 +725,99 @@ int __init da8xx_register_cpuidle(void)
>>
>>       return platform_device_register(&da8xx_cpuidle_device);
>>   }
>> +
>> +static struct resource da8xx_spi0_resources[] = {
>> +    [0] = {
>> +        .start    = 0x01c41000,
>> +        .end    = 0x01c41fff,
> 
>    BTW, I suggest to declare DA8XX_SPI0_BASE, not to deviate from the tradition developed in this file...
> 


OK. Thanks.

>> +static struct resource da8xx_spi1_resources[] = {
>> +    [0] = {
>> +        .start    = 0x01f0e000,
>> +        .end    = 0x01f0efff,
> 
>    The same about DA8XX_SPI1_BASE...
> 

Thanks.

> WBR, Sergei
