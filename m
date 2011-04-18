From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 18 Apr 2011 18:14:51 +0200
Subject: [RFC 0/4] convert stmp into mxs and delete the obsolete platform
In-Reply-To: <201104180910.45599.arnd@arndb.de>
References: <1303093838-23959-1-git-send-email-w.sang@pengutronix.de>
	<201104180707.04176.arnd@arndb.de>
	<20110418051602.GC11578@pengutronix.de>
	<201104180910.45599.arnd@arndb.de>
Message-ID: <20110418161451.GE23814@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> What about the arch/arm/mach-stmp37xx/stmp37xx_devb.c file? You don't seem
> to have a replacement for that machine.

Hmm, maybe we should skip the discussion until the patches arrived. I explained
a few things in the patch descriptions to explain the removals. For those
interested, besides the branch I mentioned before

  git://git.pengutronix.de/git/wsa/linux-2.6.git remove_stmp

there is also the web-interface for it

  http://git.pengutronix.de/?p=wsa/linux-2.6.git;a=shortlog;h=refs/heads/remove_stmp

> Also, I noticed that the same series that added support for the platform
> also added a few device drivers:
>  * drivers/rtc/rtc-stmp3xxx.c
>  * drivers/spi/spi_stmp.c
>  * drivers/watchdog/stmp3xxx_wdt.c
> 
> Are these still used by the new code, and shared with the other i.MX23
> code, or is there more duplication?

As mentioned, mach-mxs replacements are scheduled for 2.6.40. When those are in
place, the old ones can be removed, too.

> Finally, there are defconfig files:
>  * arch/arm/configs/stmp378x_defconfig
>  * arch/arm/configs/stmp37xx_defconfig
> 
> I would guess that these need to be updated.

Yup! Will do.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110418/9b215124/attachment.sig>
