From: andy@warmcat.com (Andy Green)
Date: Tue, 20 Oct 2009 11:09:07 +0100
Subject: [PATCH] input/touchscreen: add S3C24XX SoC touchscreen input
	driver
In-Reply-To: <2accc2ff0910200121g4f2c0839l96c7d99e4f4de47a@mail.gmail.com>
References: <mailman.4020.1255949705.2256.linux-arm-kernel@lists.infradead.org>	<4ADC4D4D.5020508@gmail.com>	<20091019120744.GB7412@n2100.arm.linux.org.uk>
	<2accc2ff0910192121t27387b90t9cfd5a5252aa00cc@mail.gmail.com>
	<20091020073946.GB723@n2100.arm.linux.org.uk>
	<2accc2ff0910200121g4f2c0839l96c7d99e4f4de47a@mail.gmail.com>
Message-ID: <4ADD8C43.5060205@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/09 09:21, Somebody in the thread at some point said:

> We have problems when we don't have much pressure and in this case
> there is a lot of noise and the events that are reported by the driver
> are actually noise. This noise would be more common at pen-down before
> the adc readings settle and at pen-up.

Hi Nelson -

Just a FYI, on the board I have been working on there is a capacitive 
sensor, AD7174.  I wrote a driver for it which again uses the in-kernel 
median filter (the original Openmoko version I wrote chopped out at the 
moment) heavily and with really excellent results.  The median filters 
are pretty much like magic for certain common kinds of noise.

However, I just drop the median filter code into my tree in 
drivers/input/misc at the moment.  What would be really a good result I 
think is if the filters turned up in ./lib in an easily reusable way.

I think maybe it's a mistake to focus on the in-kernel filters being 
good for a particular touchscreen technology or even specifically 
touchscreens.  I am sure other drivers doing something completely 
different with noisy instantaneously sampled data, that won't fit into 
tslib worldview at all, can also benefit from being able to clean up 
data in a standardized way before passing it down as an input event or 
back to the device or whatever.  And once that's possible, touchscreen 
drivers of any sort have the standardized option to use it too if they 
have a reason.

Just a thought, good luck :-)

-Andy
