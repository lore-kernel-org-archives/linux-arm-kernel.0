From: koen@dominion.thruhere.net (Koen Kooi)
Date: Wed, 30 Jan 2013 21:03:27 +0100
Subject: [PATCH 1/1] drivers: net: davinci_cpdma: acknowledge interrupt
 properly
In-Reply-To: <1359575813-15703-1-git-send-email-mugunthanvnm@ti.com>
References: <1359575813-15703-1-git-send-email-mugunthanvnm@ti.com>
Message-ID: <EF466712-C5FF-4A91-BDF3-477559B02705@dominion.thruhere.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Op 30 jan. 2013, om 20:56 heeft Mugunthan V N <mugunthanvnm@ti.com> het volgende geschreven:

> CPDMA interrupts are not properly acknowledged which leads to interrupt
> storm, only cpdma interrupt 0 is acknowledged in Davinci CPDMA driver.
> Changed cpdma_ctlr_eoi api to acknowledge 1 and 2 interrupts which are
> used for rx and tx respectively.

A brief inspection shows that this still isn't following the TRM, but Pantelis' patch does. Can you please fix this driver to follow the TRM and make it work on both PG1.0 and PG2.0 instead of papering over bugs instead of fixing them properly?
