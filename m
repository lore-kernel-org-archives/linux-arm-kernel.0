From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 30 Mar 2013 16:50:30 -0400
Subject: [PATCH] ARM: kirkwood: make use of DT mvsdio on guruplug board
In-Reply-To: <1364043489-17683-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1364043489-17683-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130330205030.GX13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 23, 2013 at 01:58:09PM +0100, Sebastian Hesselbarth wrote:
> Device tree based guruplug boards still use mvsdio platform_data and
> kirkwood_sdio_init to enable sdio. DT support for sdio is already there,
> so make use of it.
> 
> This also fixes mvsdio accidentially breaking nand by configuring mpp0
> to gpio, while used also by nand (nand_io2 on mpp0).
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Tested-by: Soeren Moch <smoch@web.de>
> ---
> Cc: Soeren Moch <smoch@web.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Willy Tarreau <w@1wt.eu>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts |    4 ++++
>  arch/arm/mach-kirkwood/board-guruplug.c             |    6 ------
>  2 files changed, 4 insertions(+), 6 deletions(-)

Applied to mvebu/dt

thx,

Jason.
