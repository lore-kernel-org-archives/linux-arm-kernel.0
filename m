From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 22 Oct 2010 07:56:33 -0200
Subject: [PATCH v2] ARM: mx3: fix build failure concerning
	MXC_INT_MMC_SDHC2
In-Reply-To: <1287732052-6181-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <4CC098DB.6010406@eukrea.com>
	<1287732052-6181-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <AANLkTi=d=zO5YEkmiHPd7_QEamCsJU6zvZ0eO3wn57m5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Fri, Oct 22, 2010 at 5:20 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Commit c074512 (imx-esdhc: update devices registration) renamed
> MX35_INT_MMC_SDHC2 to MX35_INT_ESDHC2 which broke expansion of the
> MXC_INT_MMC_SDHC2 macro.
> As mxcsdhc_device1 (the only user of MXC_INT_MMC_SDHC2) is only used on
> mx31 use the MX31 prefixed symbol to define its resources. ?Moreover to
> reduce further confusion mxcsdhc_device0 is fixed accordingly and the MXC
> prefixed symbols are removed.
>
> Tested-by: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> changes since v1:
>
> ?- add a missing word in commit log
> ?- also remove MMC_SDHC[12]_BASE_ADDR

Your v1 version is already in Sascha's git tree now.

Regards,

Fabio Estevam
