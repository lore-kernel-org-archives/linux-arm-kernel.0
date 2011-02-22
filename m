From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 22 Feb 2011 16:08:35 +0100
Subject: [PATCH V2 0/5] sdhci-esdhc-imx: use gpio for write protection
	and card detection
In-Reply-To: <87wrks5dgo.fsf@lebrac.rtp-net.org>
References: <1298379500-27590-1-git-send-email-w.sang@pengutronix.de>
	<87wrks5dgo.fsf@lebrac.rtp-net.org>
Message-ID: <20110222150835.GI2755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 22, 2011 at 03:52:07PM +0100, Arnaud Patard wrote:

> Has this been tested on imx51 ? By default (even after applying your
> patches), the sdhci has quirk SDHCI_QUIRK_BROKEN_CARD_DETECTION set, so
> we're polling.

Ouch, thanks for that. I missed to delete the above quirk from
sdhci_esdhc_imx_pdata. Can you give another try removing it?

-			| SDHCI_QUIRK_BROKEN_CARD_DETECTION,

That should prevent polling. Fixed here already. Will wait for Eric's
tests and send a v3 then.

> I've been wondering if it was a good idea to configure for everyone sdhc
> host card detect pin as gpio 1 1 or gpio 1 8 on imx51, which would mean
> no more polling. What do you think ? Would it be working or it's just a
> stupid idea ?

MX51 won't need platform data. The pins can be routed to the controller,
like efika-mx51 does (judging from the source and documentation).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110222/4df3eb02/attachment.sig>
