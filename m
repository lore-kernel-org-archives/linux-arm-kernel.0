From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 09 Nov 2010 16:51:34 +0100
Subject: w1-gpio oops
In-Reply-To: <8D0E58DD-1923-4321-A0B3-9FBD2DDA3529@gmail.com> (Alan Pearson's
	message of "Tue, 9 Nov 2010 15:40:19 +0000")
References: <E0675DE1-DC0C-40AE-947B-D4BD96C18993@gmail.com>
	<86F2C9C455334D048B154F93A214DF12@wipblrx0099946>
	<BFBAEA51-E7E6-4960-848D-5904BB209102@gmail.com>
	<AAD30849854E4B829FAF535B604B1B34@wipblrx0099946>
	<8D0E58DD-1923-4321-A0B3-9FBD2DDA3529@gmail.com>
Message-ID: <87lj524hrt.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alan Pearson <alandpearson@gmail.com> writes:

Hi,

>>> ----- Original Message ----- From: "Alan Pearson" <alandpearson@gmail.com>
>>> To: <linux-arm-kernel@lists.infradead.org>
>>> Sent: Tuesday, November 09, 2010 7:29 PM
>>> Subject: w1-gpio oops
>>> 
>>> 
>>>> Hi Guys,
>>>> 
>>>> First post to list, so be kind :)
>>>> 
>>>> I'm trying to get w1 (one wire) working over GPIO and despite my best efforts this results in a nasty oops.
>>>> Firstly, I'd like to say I'm no kernel hacker and my knowledge of Ooops and kernel debugging is limited, but I'm willing to learn:)
>>> 
>>> Common cause for these errors could be nonexistent or incorrect platform data. Might be worth checking if w1_gpio_platform_data
>>> is proper in your board file. You could look for examples in other board files like arch/arm/mach-pxa/raumfeld.c
>>> 
>> 
>> <CHOP>
>> 
>> Ok, I had understood the platform data was being set in the w1_gpio_custom module by the loadable options.
>> Is this not the case, or does it also need defined in the board file, which I presume is guruplug_setup.c ?
>> It's currently not defined there. But as I said I expected the other module to do this, am I wrong ?
>> 
>> 
>> Looking at the function w1_gpio_probe, it doesnot seem to be using module params. So u might need to define those
>> in your board file.
>> 
>
> OK, I've modified my board file like so (guruplug-setup.c) :
>
>
> static struct w1_gpio_platform_data guru_gpio_platform_data = {
>         .pin                    = MPP38_GPIO,

It's 38 not MPP38_GPIO. MPP38_GPIO is for the guruplug_mpp_config[]
stuff (looks at how the leds are configured for instance)


Arnaud
