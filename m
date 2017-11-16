From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Nov 2017 15:47:44 +0800
Subject: [PATCH v4 3/3] ARM: imx: Update spi_imx platform data to reflect
 current state
In-Reply-To: <20171106194618.9421-4-tpiepho@impinj.com>
References: <20171106194618.9421-1-tpiepho@impinj.com>
 <20171106194618.9421-4-tpiepho@impinj.com>
Message-ID: <20171116074743.GC25384@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 06, 2017 at 11:46:18AM -0800, Trent Piepho wrote:
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
> CC: Shawn Guo <shawnguo@kernel.org>

Acked-by: Shawn Guo <shawnguo@kernel.org>
