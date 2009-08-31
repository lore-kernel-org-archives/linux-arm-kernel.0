From: smunnings@gabaedevelopment.com (Stephen Munnings)
Date: Mon, 31 Aug 2009 14:44:19 -0400
Subject: AT91SAM9260: How to output PCK0 clock on a GPIO pin
In-Reply-To: <bb8f28f395b9416e1c2b1877be6f3baf@colcan.ca>
References: <fb43ffa34296dae697dbadb98e53bdc1@colcan.ca>
	<4A9C0136.3080102@gabaedevelopment.com>
	<bb8f28f395b9416e1c2b1877be6f3baf@colcan.ca>
Message-ID: <4A9C1A03.2050908@gabaedevelopment.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pedro I. Sanchez wrote:
>> But, I also found that you must have the PMC clock for the GPIOC bank 
>> running before GPIO (even the configuration, it seems) will work.
>> I am not sure if I had this issue in Linux, or only in the loaders, but 
>> I did have to turn on the PMC clocks to get any GPIO based things working.
>>     
>> The standard boot loader only seems to turn on GPIOA, but I am also 
>> using GPIOB and GPIOC, and I had to turn on the PMC clocks for those
>> also before I could get very far.
>>
>> Stephen Munnings
>>     
>
> Thanks Stephen,
>
> And how do I turn on the PMC clocks for the GPIO?
>
>   
I did some more searching, and it appears that Linux for at91 turns on 
all the GPIO PMC clocks as part
of its initialization.  So, the problem appears to not be the PMC clocks.
(It does it in /arch/arm/mach-at91/gpio.c in function at91_gpio_init() )

I do presume that you have the appropriate support configured into your 
kernel when you compiled it.
