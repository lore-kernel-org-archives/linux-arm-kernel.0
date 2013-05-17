From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 17 May 2013 12:50:39 +0200
Subject: [PATCH 0/3] staging: fix parallel display regressions
In-Reply-To: <1368782393-9660-1-git-send-email-list-09_linuc_arm@tqsc.de>
References: <1368782393-9660-1-git-send-email-list-09_linuc_arm@tqsc.de>
Message-ID: <1368787839.4011.4.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

Am Freitag, den 17.05.2013, 11:19 +0200 schrieb Markus Niebel:
> From: Markus Niebel <Markus.Niebel@tqs.de>
> 
> Support for VGA via TVE on iMX53 causes  regression, which prevents
> parallel display from working. This series brings the parallel display
> functionality back.
> 
> Tested on a modified v3.9 with TQMa53 module and compile tested with
> v3.10-rc1.
> 
> Markus Niebel (3):
>   staging: drm/imx: set correct sync pins for parallel display
>   staging: drm/imx: fix spelling error for vsync flag config
>   staging: drm/imx: revert vsync_cnt for di->id 1
> 
>  drivers/staging/imx-drm/ipu-v3/ipu-di.c    |   13 +++++++++----
>  drivers/staging/imx-drm/parallel-display.c |    4 ++--
>  2 files changed, 11 insertions(+), 6 deletions(-)

thank you for posting the patches! I can confirm that they fix the
issues of incorrect signal generation on IPU display interface 1,
caused by my TVE patch series.

Tested-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
