From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Thu, 30 Sep 2010 10:31:58 +0200
Subject: [PATCH 4/6] mmc: sdhci_pltfm: pass more data on custom init-call
In-Reply-To: <1285790884-3516-5-git-send-email-w.sang@pengutronix.de>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
	<1285790884-3516-5-git-send-email-w.sang@pengutronix.de>
Message-ID: <19620.19198.88841.623775@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Wolfram Sang writes:
> The custom init call may need more data to perform its job, so we pass
> it a pointer to pdata, too. Also, always use the platform_id specific
> data even if platform_data is present. Doing that, platform_data can
> additionally be parsed by init() for board-specific information (via
> sdhci->mmc->parent).
> 
Why not a pointer to the platform_device itself? Then the callback
function would have even more information (e.g. platform_device ID)
and could easily get at the platform_data too.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
