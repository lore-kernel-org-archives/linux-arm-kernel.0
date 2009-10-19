From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 19 Oct 2009 16:44:39 +0200
Subject: [PATCH] input/touchscreen: add S3C24XX SoC touchscreen input
	driver
In-Reply-To: <1255959111.3708.32.camel@sl> (Shine Liu's message of "Mon\,
	19 Oct 2009 21\:31\:51 +0800")
References: <mailman.4020.1255949705.2256.linux-arm-kernel@lists.infradead.org>
	<4ADC4D4D.5020508@gmail.com> <1255959111.3708.32.camel@sl>
Message-ID: <87zl7nqw88.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shine Liu <shinel@foxmail.com> writes:

Hi,

> On Mon, 2009-10-19 at 13:28 +0200, Maurus Cuelenaere wrote:
>
>> Do you know that there's another patch (at Openmoko) created by Nelson 
>> Castillo that does the same, but also has support for kernel-space 
>> touchscreen filters? (I think [1] is his latest version)
>> I don't know how your patch performs, but according to [2] the filters 
>> should help a lot avoiding jitter etc.
>> 
>> I'm not sure whether Nelson has submitted his patches for mainline 
>> review yet and what the status is on the kernel filters, but IMHO doing 
>> some filtering in kernel space (see the "Why are we doing filtering in 
>> kernel space?" part of [2]) which results in a "cleaner" output is 
>> preferred over reporting possible "jittery" data.
>
> Yes, I do,  because part of my patch comes from source code of openmoko
> project. I've also noticed there's 4 touchscreen filters in the openmoko
> project used by s3c24xx touchscreen driver.
>
> I think there should be a s3c24xx touchscreen driver in the mailine, but
> I haven't found anyone submitted a s3c24xx touchscreen driver for the
> mainline. So I wrote the driver myself and refered the openmoko
> implementation.

Please have a look at the arm-kernel mailing list archive. There has
been some discussion about that. The idea was to compare between the
openmoko's version and Simtec's version and choose the best version. Both
are coming from the h1940 tree (fwiw written by me and it would have
been nice to tell in your header you've taken the code from openmoko's
tree) and both have been updated to take into account the adc support
given by arch/arm/plat-s3c24xx/adc.c. 

As regards why there's no driver yet, there's a reason. The adc
stuff didn't exist when the driver was written and it was not a good
idea to merge it because enabling it was meaning no hwmon support. Same
problem if the hwmon support was enabled, no touchscreen support. So, it
was decided to wait for a proper adc support. Now that Ben wrote it,
it's time to discuss about merging it.

So, please have a look at the driver which was posted by Ben some days
ago and comments/reply to his mail if you have problem with his
version. The driver has been in Simtec's patchset since quite a long
time so I tend to believe that this one is working nicely.

Thanks,
Arnaud
