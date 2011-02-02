From: michael.williamson@criticallink.com (Michael Williamson)
Date: Wed, 02 Feb 2011 07:59:30 -0500
Subject: [PATCH v1 1/4] davinci: da8xx/omap-l1: add support for SPI
In-Reply-To: <4D494E0D.4090207@mvista.com>
References: <1296596979-18524-1-git-send-email-michael.williamson@criticallink.com>
	<1296596979-18524-2-git-send-email-michael.williamson@criticallink.com>
	<4D494E0D.4090207@mvista.com>
Message-ID: <4D495532.7020205@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/2/2011 7:29 AM, Sergei Shtylyov wrote:

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
>> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
>> index 3443d97..68fe4c2 100644
>> --- a/arch/arm/mach-davinci/da850.c
>> +++ b/arch/arm/mach-davinci/da850.c
> [...]
>> @@ -403,6 +417,8 @@ static struct clk_lookup da850_clks[] = {
>>       CLK(NULL,        "aemif",    &aemif_clk),
>>       CLK(NULL,        "usb11",    &usb11_clk),
>>       CLK(NULL,        "usb20",    &usb20_clk),
>> +    CLK("spi_davinci.0",    NULL,        &spi0_clk),
>> +    CLK("spi_davinci.1",    NULL,        &spi1_clk),
> 
>    BTW, da830.c has "dm_spi.[01]" instead -- which should be fixed (by yet another patch).
> 


As I am going around the loop again, I will add a separate patch to the series to rename
this clock to spi_davinci.[01].  Thanks for the close look.  I clearly missed some of the
da830 details.

>>       CLK(NULL,        NULL,        NULL),
>>   };
>>
> 
> WBR, Sergei
