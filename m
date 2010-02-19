From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 19 Feb 2010 12:02:10 +0200
Subject: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
In-Reply-To: <20100219091755.GB2856@core.coreip.homeip.net>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
	<1266510750-9846-3-git-send-email-anarsoul@gmail.com>
	<20100219091755.GB2856@core.coreip.homeip.net>
Message-ID: <201002191202.16384.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

? ????????? ?? 19 ??????? 2010 11:17:55 ????? Dmitry Torokhov ???????:

> I do not think this is right. Here you reset sampling data regardless
> of whether you got the right number of samples or not. You should repeat
> s3c_adc_start only if you got (1 << ts.shift) samples. But I think I see
> why touchpad may stop reporintg sometimes - if timer fires before you
> get the needed number of samples nothing will happen as timer is not
> gettign rearmed.

Problem is driver reports "stylus down" event when stylus is already up, 
anyway I agree that samples should not be discarded.

> >  	} else {
> >  	
> >  		ts.count = 0;
> 
> I also think this branch is missing ts.xp = ts.yp = 0;

Ok.

Fixed version is in attachment

Thanks for review.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-s3c24xx_ts-report-touch-only-when-stylus-is-down.patch
Type: text/x-patch
Size: 1904 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100219/506975f2/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100219/506975f2/attachment.sig>
