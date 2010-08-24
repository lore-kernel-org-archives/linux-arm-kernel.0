From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 24 Aug 2010 17:56:06 +0300
Subject: [PATCH 3/3] h1940: implement mmc_power function
In-Reply-To: <201008241641.57621.marek.vasut@gmail.com>
References: <1282230003-2020-1-git-send-email-anarsoul@gmail.com>
	<201008241721.11669.anarsoul@gmail.com>
	<201008241641.57621.marek.vasut@gmail.com>
Message-ID: <201008241756.11529.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 24 ??????? 2010 17:41:57 ????? Marek Vasut ???????:
> Dne ?t 24. srpna 2010 16:21:01 Vasily Khoruzhick napsal(a):
> > ? ????????? ?? 24 ??????? 2010 17:01:12 ????? Marek Vasut ???????:
> > > pr_err() and don't probe the device for which you couldn't request
> > > GPIO.
> > 
> > Well, handling those errors in machine init functions doesn't make sense.
> > PDA is not usable without basic hardware.
> 
> You can use PDA without LCD for example (there are such people, trust me).
> So, this comment really isn't too valid. You can also use PDA without MMC
> support, you still have onboard flash, etc. etc.

But error handling here just increases code size, and gpio_request in init 
function should always succeed. It means something's going really wrong 
(kernel bug or misconfiguration) if gpio_request fails. Btw, Ben suggested to 
use WARN_ON in machine init, look through init functions of qt2410, n30, 
rx1950, vr1000, etc.

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100824/f1a44531/attachment.sig>
