From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 12 Mar 2012 11:10:37 +0100
Subject: iMX53 and MMC_CAP_SDIO_IRQ
In-Reply-To: <4F5DB793.3080904@linuxtv.org>
References: <4F5DB793.3080904@linuxtv.org>
Message-ID: <20120312101037.GA2459@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> The main problem is that the ancient Freescale 2.6.35 kernel is using
> the "mx_sdhci" driver, while in 3.3.0-rc6+ the generic "sdhci" driver is
> used, so it's not possible to simply compare the changes between the two
> versions. :-(

Not via diff, but the structure of both drivers should still be somewhat
similar.

> Probably this is a question for the Freescale people: why was the
> "mx_sdhci" necessary at all

It probably was never necessary, it was just easier to hack on a forked
driver, because you can't break other sdhci-users, I guess. Since large
portions of the code are duplicated but issues have been fixed in a
very, ahem, custom manner, this was never suitable for mainline. Back
then, most vendors thought this is good enough. Luckily, times have
changed a bit.

> and why is it not necessary any more?

Because I wanted SD support in mainline, so I had to take a different
path.

> Any help, hints and historical informations are highly appreciated,
> before I start to look deeper into this problem.

They don't have a common ancestor. Just dig into both, you will
recognize patterns, I guess.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120312/a3c71675/attachment-0001.sig>
