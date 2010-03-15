From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 15 Mar 2010 22:16:57 +0200
Subject: [PATCH] ARM: SAMSUNG: Add suspend/resume support for S3C PWM
	driver
In-Reply-To: <4B9E8C25.80904@metafoo.de>
References: <1268663228-27515-1-git-send-email-anarsoul@gmail.com>
	<4B9E8C25.80904@metafoo.de>
Message-ID: <201003152217.02781.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 15 ????? 2010 21:36:05 ????? Lars-Peter Clausen ???????:

> Hi
> 
> There is still one big issue left regarding pwm suspend/resume.
> If the invert bit is not set, the pwm will generate a HIGH signal when
> being inactive, when the bit is set it will generate a HIGH signal when
> active.
> As a result any pin to which the pwm signal is routed will appear as
> active until the pwm resume handler is called. This usually takes a few
> 100 ms seconds and so for a short period of time we'll get the wrong
> signal on pwm pins.
> For correct behavior the pwm driver would have to check all pins to
> which it's signal might be routed and if it's actually is configure the
> pin as LOW output.
> Upon resume the pin then has to be reconfigured as a pwm pin, only after
> the invert bit has been set.
> 
> I know that it previously has been stated, that it is not desired for
> the pwm driver to know about gpio pins. But in my opinion to ensure
> correct behavior it is unavoidable.
> 
> - Lars

Hi, why not to leave this job for driver that use PWM? This driver should 
disable PWM before going to suspend and ensure that GPIO pin is in right 
state. (For example, I'm using pwm-bl callbacks to manage gpio pin state when 
PWM is disabled).

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100315/8292d817/attachment.sig>
