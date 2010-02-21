From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 21 Feb 2010 23:44:34 +0200
Subject: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
In-Reply-To: <2accc2ff1002210627i25a76293x398b2806a6dbb200@mail.gmail.com>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
	<201002211210.12306.anarsoul@gmail.com>
	<2accc2ff1002210627i25a76293x398b2806a6dbb200@mail.gmail.com>
Message-ID: <201002212344.39633.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 21 ??????? 2010 16:27:13 ????? Nelson Castillo ???????:
> I remember I got bit by this also when I scheduled more conversions
> without a timer; pen-up event would not get noticed. I didn't check
> the specs to see if there was a way to configure the HW to do
> otherwise.

UPDOWN bits in ADCDAT0 and ADCDAT1 are valid only in WAIT4INT mode, it's wrong 
to check them in select callback because ADC is not in WAIT4INT mode.

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100221/fb2d0a61/attachment.sig>
