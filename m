From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 21 Feb 2010 11:05:26 +0200
Subject: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
In-Reply-To: <20100221073512.GA18298@core.coreip.homeip.net>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
	<201002191202.16384.anarsoul@gmail.com>
	<20100221073512.GA18298@core.coreip.homeip.net>
Message-ID: <201002211105.30079.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 21 ??????? 2010 09:35:13 ????? Dmitry Torokhov ???????:

> Applied, thank you Vasily.
> 
> One more thing though - why do we need that timer to report input events
> and reschedule ADC conversions? It looks like it is not really needed.
> Could you please give a try to the patch below?
> 
> Thanks!

Timer is used to avoid reporting input events in interrupt context (select 
callback is called from s3c_adc_try and from s3c_adc_irq), Is it safe to call 
input_report_abs/input_report_key from interrupt context? Anyway, driver 
doesn't work for me with this patch (it works as mouse, but it doesn't as 
touchscreen through tslib)

Regards,
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100221/461a0fd3/attachment.sig>
