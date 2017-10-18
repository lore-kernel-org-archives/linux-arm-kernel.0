From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 18 Oct 2017 10:17:11 +0800
Subject: [PATCH 4/4] ARM: imx: Update spi_imx platform data to reflect
 current state
In-Reply-To: <20171013195410.30767-4-tpiepho@impinj.com>
References: <20171013195410.30767-1-tpiepho@impinj.com>
 <20171013195410.30767-4-tpiepho@impinj.com>
Message-ID: <20171018021709.GD18810@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 13, 2017 at 12:54:10PM -0700, Trent Piepho wrote:
> The docs for the spi_imx platform data still refer to a -32 offset used to
> specify a native chip select.  This was removed in commit 602c8f4485cd
> ("spi: imx: fix use of native chip-selects with devicetree") and no
> longer works as documented.  Update documentation.
> 
> The macro MXC_SPI_CS() is no longer is needed.
> 
> If a board uses all native chip selects, then it's not necessary to
> specify a chip select array at all, as all native is the default (this is
> how device-tree configured SPI masters work too).  Most of the spi-imx
> platform data users have their chip select arrays removed by this patch.
> 
> This patch also fixes a bug in mx31moboard introduced in the '602 commit.
> When that board was updated in commit 901f26bce64a ("ARM: imx: set
> correct chip_select in platform setup") to reflect the SPI change, only
> SPI bus 2 was updated and SPI bus 1 was left with non-sequential chip
> selects.  The mc13783 spi device on bus 1 had its chip select updated as
> if it were on bus 2.
> 
> CC: Greg Ungerer <gerg@linux-m68k.org>
> CC: Shawn Guo <shawnguo@kernel.org>
> CC: Sascha Hauer <kernel@pengutronix.de>
> CC: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>

Does this patch have any dependency on others in this series, or can it
be sent via arm-soc tree independently?

Shawn
