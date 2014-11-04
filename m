From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 4 Nov 2014 16:26:46 +0100
Subject: [PATCH v2] ARM: imx: Fix the removal of CONFIG_SPI option
In-Reply-To: <1415096927-4097-1-git-send-email-festevam@gmail.com>
References: <1415096927-4097-1-git-send-email-festevam@gmail.com>
Message-ID: <20141104152646.GA8450@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Note, this is a resend of a mail I accidently only sent to Fabio 
before.]

Hello,

On Tue, Nov 04, 2014 at 08:28:47AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since 64546e9fe3a5b8c ("ARM: imx_v6_v7_defconfig updates") and commit 
> 0650f855d2e4b0b9 ("ARM: imx_v4_v5_defconfig: Select CONFIG_IMX_WEIM") CONFIG_SPI
> selection was dropped by savedefconfig for imx_v4_v5_defconfig and 
> imx_v6_v7_defconfig.
> 
> In order to keep the same behaviour as previous kernel versions and avoid 
> regressions, let's add CONFIG_SPI option back.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Add commit id's that caused the issue.
on top of 64546e9fe3a5b8c doing

        make imx_v6_v7_defconfig

resulted in CONFIG_SPI=y. That's because MEDIA_SUBDRV_AUTOSELECT selects
SPI and has default y.

So the commit that really broke imx_v6_v7_defconfig is 7d24c514e8e0
([media] Kconfig: do not select SPI bus on sub-driver auto-select).
On a side note I wonder how that commit sneaked into v3.17-rc6.

I think people need to be more aware of the results of Kconfig changes
...

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
