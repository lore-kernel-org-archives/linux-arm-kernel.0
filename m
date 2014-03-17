From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 17 Mar 2014 10:05:08 +0100
Subject: [PATCH v2 3/5] net: cpsw: Add control-module macid driver
In-Reply-To: <1394888864-11007-4-git-send-email-mpa@pengutronix.de>
References: <1394888864-11007-1-git-send-email-mpa@pengutronix.de>
 <1394888864-11007-4-git-send-email-mpa@pengutronix.de>
Message-ID: <20140317090508.GN15674@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Markus,

On Sat, Mar 15, 2014 at 02:07:42PM +0100, Markus Pargmann wrote:
> This driver extracts the hardware macid from the control module of
> am335x processors. It exports a function cpsw_ctrl_macid_read for cpsw
> to get the macid from within the processor.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  .../devicetree/bindings/net/cpsw-ctrl-macid.txt    |  32 +++++
>  drivers/net/ethernet/ti/Kconfig                    |   1 +
>  drivers/net/ethernet/ti/Makefile                   |   2 +-
>  drivers/net/ethernet/ti/cpsw-ctrl-macid.c          | 138 +++++++++++++++++++++
>  4 files changed, 172 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/net/cpsw-ctrl-macid.txt
>  create mode 100644 drivers/net/ethernet/ti/cpsw-ctrl-macid.c
> 
> diff --git a/Documentation/devicetree/bindings/net/cpsw-ctrl-macid.txt b/Documentation/devicetree/bindings/net/cpsw-ctrl-macid.txt
> new file mode 100644
> index 0000000..4eb39f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/cpsw-ctrl-macid.txt
> @@ -0,0 +1,32 @@
> +TI CPSW ctrl macid Devicetree bindings
> +--------------------------------------
> +
> +Required properties:
> + - compatible		: Should be "ti,am3352-cpsw-ctrl-macid"
this is called am3352-..., still you add it (in patch 5) to am33xx.dtsi
and in the commit log you wrote about am335x. Looks abstruse.

> + - reg			: physical base address and size of the cpsw
> +			  registers map
> + - reg-names		: names of the register map given in "reg" node
> + - #ti,mac-address-ctrl-cells	: Should be <1>
Would be sensible to drop this property, or at least let it default to 1
if missing?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
