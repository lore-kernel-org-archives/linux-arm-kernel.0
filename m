From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 11 Dec 2009 18:12:35 -0500
Subject: GPIO support for HTC Dream
In-Reply-To: <d6200be20912111440k427c5013j2b17191bcbae2d52@mail.gmail.com>
References: <20091208102842.GH12264@elf.ucw.cz>
	<4B1EB57D.6070408@bluewatersys.com>
	<20091208214658.GC4164@elf.ucw.cz>
	<4B1ECEEE.3000209@bluewatersys.com>
	<4B203575.6050407@bluewatersys.com>
	<20091210172458.GJ19454@elf.ucw.cz>
	<4B2150B7.3040207@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901FB0F92@mi8nycmail19.Mi8.com>
	<20091211221015.GB24456@elf.ucw.cz>
	<d6200be20912111440k427c5013j2b17191bcbae2d52@mail.gmail.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901FB10EB@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 11, 2009 3:41 PM, Arve Hj?nnev?g wrote:

<snip>

>> Now, it will still need some cleanups -- I'm not sure if gpios are
>> dream-specific or generic for whole msm.... I kind of assume they
>> should be generic for msm. Google people, can you help?
>
> I'm not exactly sure what you are asking. Gpios in general are not
> dream specific, the code in board-dream-gpio.c is. Some gpios (e.g.
> DREAM_4_BALL_UP_0) are used for a dream specific function, but point
> to a gpio that is generic to the msm architecture.

<snip>

>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 1c4119c..8bb8546 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -565,6 +565,8 @@ config ARCH_MSM
>> ? ? ? ?select CPU_V6
>> ? ? ? ?select GENERIC_TIME
>> ? ? ? ?select GENERIC_CLOCKEVENTS
>> + ? ? ? select GENERIC_GPIO
>> + ? ? ? select ARCH_REQUIRE_GPIOLIB
>
> Please do not do this in a board specific change. You have not changed
> the msm generic gpio support to use gpiolib.

Where is the msm tree located?  mach-msm in mainline doesn't appear to
have _any_ gpio support.  Is Pavel's implementation generic enough to
work with any msm based board?

Regards,
Hartley
