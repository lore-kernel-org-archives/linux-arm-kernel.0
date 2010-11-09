From: hemanthv@ti.com (Hemanth V)
Date: Tue, 9 Nov 2010 20:23:59 +0530
Subject: w1-gpio oops
References: <E0675DE1-DC0C-40AE-947B-D4BD96C18993@gmail.com>
	<86F2C9C455334D048B154F93A214DF12@wipblrx0099946>
	<BFBAEA51-E7E6-4960-848D-5904BB209102@gmail.com>
Message-ID: <AAD30849854E4B829FAF535B604B1B34@wipblrx0099946>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

----- Original Message ----- 
From: "Alan Pearson" <alandpearson@gmail.com>
To: "Hemanth V" <hemanthv@ti.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Sent: Tuesday, November 09, 2010 8:14 PM
Subject: Re: w1-gpio oops



On 9 Nov 2010, at 14:29, Hemanth V wrote:

> ----- Original Message ----- From: "Alan Pearson" <alandpearson@gmail.com>
> To: <linux-arm-kernel@lists.infradead.org>
> Sent: Tuesday, November 09, 2010 7:29 PM
> Subject: w1-gpio oops
>
>
>> Hi Guys,
>>
>> First post to list, so be kind :)
>>
>> I'm trying to get w1 (one wire) working over GPIO and despite my best 
>> efforts this results in a nasty oops.
>> Firstly, I'd like to say I'm no kernel hacker and my knowledge of Ooops 
>> and kernel debugging is limited, but I'm willing to learn:)
>
> Common cause for these errors could be nonexistent or incorrect platform 
> data. Might be worth checking if w1_gpio_platform_data
> is proper in your board file. You could look for examples in other board 
> files like arch/arm/mach-pxa/raumfeld.c
>

<CHOP>

Ok, I had understood the platform data was being set in the w1_gpio_custom 
module by the loadable options.
Is this not the case, or does it also need defined in the board file, which 
I presume is guruplug_setup.c ?
It's currently not defined there. But as I said I expected the other module 
to do this, am I wrong ?


Looking at the function w1_gpio_probe, it doesnot seem to be using module 
params. So u might need to define those
in your board file.
