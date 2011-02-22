From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 22 Feb 2011 15:52:07 +0100
Subject: [PATCH V2 0/5] sdhci-esdhc-imx: use gpio for write protection and
	card detection
In-Reply-To: <1298379500-27590-1-git-send-email-w.sang@pengutronix.de>
	(Wolfram Sang's message of "Tue, 22 Feb 2011 13:58:15 +0100")
References: <1298379500-27590-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <87wrks5dgo.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram Sang <w.sang@pengutronix.de> writes:

> Hi,

Hi,

>
> Second version of my series, no major changes:
>
> * rephrased warnings
> * collected some tags
> * rebased to mmc/mmc-next as of today
>
> Eric wanted to tested these patches soonish. Thanks to Marc for testing the
> first three already.

Has this been tested on imx51 ? By default (even after applying your
patches), the sdhci has quirk SDHCI_QUIRK_BROKEN_CARD_DETECTION set, so
we're polling.
I've been wondering if it was a good idea to configure for everyone sdhc
host card detect pin as gpio 1 1 or gpio 1 8 on imx51, which would mean
no more polling. What do you think ? Would it be working or it's just a
stupid idea ?

Arnaud
