From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 18 Dec 2013 01:46:19 +0100
Subject: [PATCH RFC 1/2] pinctl: sh-pfc: r7s72100: Ethernet support
In-Reply-To: <1387095840-15008-2-git-send-email-horms+renesas@verge.net.au>
References: <1387095840-15008-1-git-send-email-horms+renesas@verge.net.au>
 <1387095840-15008-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <6515176.hyhvVkecWa@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thank you for the patch.

On Sunday 15 December 2013 17:23:59 Simon Horman wrote:
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> 
> This has not been well exercised.
> ---
>  drivers/pinctrl/sh-pfc/pfc-r7s72100.c | 64 ++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r7s72100.c
> b/drivers/pinctrl/sh-pfc/pfc-r7s72100.c index c5bb533..77b4ce7 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r7s72100.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r7s72100.c
> @@ -141,15 +141,79 @@ static const unsigned int __RZ_STR(pfx, hw, bank, pin,
> _mux)[] = {	\
> 
>  SCIF2(RZ_PIN_AND_MUX)
> 
> +#define ETHERNET(fn)			\
> +	fn(ethernet, col,    1,  3, 3)		\
> +	fn(ethernet, col,    1, 14, 4)		\
> +	fn(ethernet, int,    1, 15, 1)		\
> +	fn(ethernet, txclk,  2,  0, 2)		\
> +	fn(ethernet, txer,   2,  1, 2)		\
> +	fn(ethernet, txen,   2,  2, 2)		\
> +	fn(ethernet, txcrs,  2,  3, 2)		\
> +	fn(ethernet, txd,    2,  4, 2)		\
> +	fn(ethernet, txd,    2,  5, 2)		\
> +	fn(ethernet, txd,    2,  6, 2)		\
> +	fn(ethernet, txd,    2,  7, 2)		\

Those pins should be called txd0, txd1, txd2 and txd3. Same below for the txd 
and rxd pins.

> +	fn(ethernet, rxd,    2,  8, 2)		\
> +	fn(ethernet, rxd,    2,  9, 2)		\
> +	fn(ethernet, rxd,    2, 10, 2)		\
> +	fn(ethernet, rxd,    2, 11, 2)		\
> +	fn(ethernet, txclk,  3,  0, 2)		\
> +	fn(ethernet, txer,   3,  1, 2)		\
> +	fn(ethernet, txen,   3,  2, 2)		\
> +	fn(ethernet, mdio,   3,  3, 2)		\
> +	fn(ethernet, rxclk,  3,  4, 2)		\
> +	fn(ethernet, rxer,   3,  5, 2)		\
> +	fn(ethernet, rxdv,   3,  6, 2)		\
> +	fn(ethernet, mdc,    5,  9, 2)		\
> +	fn(ethernet, mdc,    7,  0, 3)		\
> +	fn(ethernet, txclk,  7,  1, 3)		\
> +	fn(ethernet, txer,   7,  2, 3)		\
> +	fn(ethernet, txen,   7,  3, 3)		\
> +	fn(ethernet, txd,    7,  4, 3)		\
> +	fn(ethernet, txd,    7,  5, 3)		\
> +	fn(ethernet, txd,    7,  6, 3)		\
> +	fn(ethernet, txd,    7,  7, 3)		\
> +	fn(ethernet, rxd,    7,  9, 3)		\
> +	fn(ethernet, rxd,    7, 10, 3)		\
> +	fn(ethernet, rxd,    7, 11, 2)		\
> +	fn(ethernet, rxd,    7, 12, 3)		\
> +	fn(ethernet, mdio,   7, 13, 3)		\
> +	fn(ethernet, crs,    7, 14, 3)		\
> +	fn(ethernet, rxclk,  7, 15, 3)		\
> +	fn(ethernet, rxer,   8,  0, 3)		\
> +	fn(ethernet, rxd,    8,  1, 3)		\
> +	fn(ethernet, col,    8,  7, 5)		\
> +	fn(ethernet, txclk, 10,  0, 4)		\
> +	fn(ethernet, txer,  10,  1, 4)		\
> +	fn(ethernet, txen,  10,  2, 4)		\
> +	fn(ethernet, crs,   10,  3, 4)		\
> +	fn(ethernet, txd,   10,  4, 4)		\
> +	fn(ethernet, txd,   10,  5, 4)		\
> +	fn(ethernet, txd,   10,  6, 4)		\
> +	fn(ethernet, txd,   10,  7, 4)		\
> +	fn(ethernet, txd,   10,  8, 4)		\
> +	fn(ethernet, txd,   10,  9, 4)		\
> +	fn(ethernet, txd,   10, 10, 4)		\
> +	fn(ethernet, txd,   10, 11, 4)		\
> +
> +ETHERNET(RZ_PIN_AND_MUX)

Could you please move this above the SCIF entries to keep the file 
alphabetically sorted ? Same for the groups and functions below.

> +
>  static const struct sh_pfc_pin_group pinmux_groups[] = {
>  	SCIF2(RZ_PMX_GRP)
> +	ETHERNET(RZ_PMX_GRP)
>  };
> 
>  static const char * const scif2_groups[] = {
>  	SCIF2(RZ_GRPS)
>  };
> +
> +static const char * const ethernet_groups[] = {
> +	ETHERNET(RZ_GRPS)
> +};
> +
>  static const struct sh_pfc_function pinmux_functions[] = {
>  	SH_PFC_FUNCTION(scif2),
> +	SH_PFC_FUNCTION(ethernet),
>  };
> 
>  #define PFC_REG(idx, name, reg)						\
-- 
Regards,

Laurent Pinchart
