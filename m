From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 24 Sep 2009 17:33:24 +0300
Subject: Problem with s3c24xx pwm driver
In-Reply-To: <f17812d70909231525t594704c5u781e2221481676a0@mail.gmail.com>
References: <200909231824.11671.anarsoul@gmail.com>
	<200909232223.35835.anarsoul@gmail.com>
	<f17812d70909231525t594704c5u781e2221481676a0@mail.gmail.com>
Message-ID: <200909241733.29167.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 24 ???????? 2009 01:25:46 ?? ????????:

> No, it doesn't.
> 
> So my suggestion at the moment is that you may:
> 
> 1. try dump the registers after pwm_enable() and see if all are setup
> correctly,
> 
> 2. and make sure those registers are write-able at that time (some
> SoC doesn't allow register writing when the controller is disabled).

Ok, I've found source of  problem: it seems to be some issue with backlight 
LED driver (hardware, not software) with selected PWM clock. It seems that  
part of period with "1" is not long enought to charge capacitor, or something 
like this. PWM itself works fine.

Sorry for buzz.

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090924/3da13106/attachment.sig>
