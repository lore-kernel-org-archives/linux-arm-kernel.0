From: lars@metafoo.de (Lars-Peter Clausen)
Date: Fri, 19 Nov 2010 11:42:02 +0100
Subject: [PATCH] ARM: s3x24xx: Fix gpiochip_add complaining.
In-Reply-To: <201011191123.22255.anarsoul@gmail.com>
References: <1290158139-16105-1-git-send-email-marek.belisko@open-nandra.com>
	<201011191123.22255.anarsoul@gmail.com>
Message-ID: <4CE6547A.9070309@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vasily Khoruzhick wrote:
> On Friday 19 November 2010 11:15:39 Marek Belisko wrote:
>> Make mini2440_defconfig. During kernel startup there is:
>> gpiochip_add: gpios 288..303 (GPIOK) failed to register
>> gpiochip_add: gpios 320..334 (GPIOL) failed to register
>> gpiochip_add: gpios 352..353 (GPIOM) failed to register
>>
>> because s3c2440 doesn't have following gpios. Gpios are
>> available only at upper cpu version (s3c2443).
> 
> These warnings are harmless, and your patch prevents building single binary 
> kernel for all s3c24xx socs (however, it's already broken by latest pull-
> up/pull-down changes)
> 
> Regards
> Vasily
> 

Hi

Well it actually causes problems on systems with external gpio expanders, because now
the additional banks will take up the space which was meant for the gpio expander
chip and peripherals connected to it wont be accessible.

I sent a patch[1] about this some time ago, but I guess it was never applied...

- Lars
[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2010-September/026382.html

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
