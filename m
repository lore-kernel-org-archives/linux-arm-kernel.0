From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 14 May 2013 09:01:47 +0200
Subject: [PATCH] net/macb: fix ISR clear-on-write behavior only for
 some SoC
In-Reply-To: <1368461105-23128-1-git-send-email-nicolas.ferre@atmel.com>
References: <1368461105-23128-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20130514070147.GB29391@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Mon, May 13, 2013 at 06:05:05PM +0200, Nicolas Ferre wrote:
> Commit 749a2b6 (net/macb: clear tx/rx completion flags in ISR)
> introduces clear-on-write on ISR register. This behavior is not always
> implemented when using Cadence MACB/GEM and is breaking other platforms.
> We are using a new Device Tree compatibility string and a capability
> property to actually activate this clear-on-write behavior on ISR.
> 
> Reported-by: Hein Tibosch <hein_tibosch@yahoo.es>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  Documentation/devicetree/bindings/net/macb.txt |  2 ++
>  drivers/net/ethernet/cadence/macb.c            | 15 +++++++++++++--
>  drivers/net/ethernet/cadence/macb.h            |  5 +++++
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 

Looks okay to me:

Acked-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
