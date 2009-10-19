From: shinel@foxmail.com (Shine Liu)
Date: Mon, 19 Oct 2009 21:31:51 +0800
Subject: [PATCH] input/touchscreen: add S3C24XX SoC touchscreen input
	driver
In-Reply-To: <4ADC4D4D.5020508@gmail.com>
References: <mailman.4020.1255949705.2256.linux-arm-kernel@lists.infradead.org>
	<4ADC4D4D.5020508@gmail.com>
Message-ID: <1255959111.3708.32.camel@sl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-10-19 at 13:28 +0200, Maurus Cuelenaere wrote:

> Do you know that there's another patch (at Openmoko) created by Nelson 
> Castillo that does the same, but also has support for kernel-space 
> touchscreen filters? (I think [1] is his latest version)
> I don't know how your patch performs, but according to [2] the filters 
> should help a lot avoiding jitter etc.
> 
> I'm not sure whether Nelson has submitted his patches for mainline 
> review yet and what the status is on the kernel filters, but IMHO doing 
> some filtering in kernel space (see the "Why are we doing filtering in 
> kernel space?" part of [2]) which results in a "cleaner" output is 
> preferred over reporting possible "jittery" data.

Yes, I do,  because part of my patch comes from source code of openmoko
project. I've also noticed there's 4 touchscreen filters in the openmoko
project used by s3c24xx touchscreen driver.

I think there should be a s3c24xx touchscreen driver in the mailine, but
I haven't found anyone submitted a s3c24xx touchscreen driver for the
mainline. So I wrote the driver myself and refered the openmoko
implementation.

I didn't use the kernel-space touchscreen filters, because I found tslib
is able to meet the common requirement.

I have read the mail of Russell King. I think we may add the s3c24xx ts
driver first, and the kernel-space touchscreen filters can be added
later if most of us think it is valuable or usefull. After all, I don't
think there is anyone like the mailine without s3c24xx ts driver
support.


Cheers,

Shine Liu
