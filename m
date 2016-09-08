From: netz.kernel@gmail.com (Marty Plummer)
Date: Thu, 8 Sep 2016 15:12:26 -0500
Subject: [RFC 1/7] Make Hi3620 explicit, remove wildcards
In-Reply-To: <4234280.g2uciTKcvR@wuerfel>
References: <20160908172346.27506-1-netz.kernel@gmail.com>
 <4234280.g2uciTKcvR@wuerfel>
Message-ID: <df45ed73-0f7a-89d0-7cc5-5b6549f2b0f9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2016 03:05 PM, Arnd Bergmann wrote:
> On Thursday, September 8, 2016 12:23:40 PM CEST Marty Plummer wrote:
> 
>>  arch/arm/Kconfig.debug | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>> index a9693b6..9094ca6 100644
>> --- a/arch/arm/Kconfig.debug
>> +++ b/arch/arm/Kconfig.debug
>> @@ -280,7 +280,7 @@ choice
>>  
>>  	config DEBUG_HI3620_UART
>>  		bool "Hisilicon HI3620 Debug UART"
>> -		depends on ARCH_HI3xxx
>> +		depends on ARCH_HI3620
>>  		select DEBUG_UART_PL01X
>>  		help
>>  		  Say Y here if you want kernel low-level debugging support
>>
> 
> While patches should normally be split up into per-subsystem
> changes, they also have to be done in an 'atomic' way:
> applying just the first patch without the second one must
> not introduce a regression.
> 
> In this case, I'd suggest simply doing a larger patch for
> the global rename to collect 'Acked-by's and send that through
> the arm-soc tree.
> 
> If you get in a similar situation with more complex changes,
> you should come up with a way to do it independently. Here
> you would first have to introduce a CONFIG_ARCH_HI3620
> symbol in one patch and make that always selected at
> the same time as CONFIG_ARCH_HI3xxx, then change all users
> of that symbol, and finally remove the original.
> 
> 	Arnd
> 
So, in this case it should be one single patch? Geeze this is hella
complicated to just get a name changed XD
