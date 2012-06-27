From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Jun 2012 10:47:24 +0200
Subject: [PATCH 1/2] net: flexcan: clock-frequency is optional for device
 tree probe
In-Reply-To: <1340700563-8386-2-git-send-email-shawn.guo@linaro.org>
References: <1340700563-8386-1-git-send-email-shawn.guo@linaro.org>
 <1340700563-8386-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <4FEAC89C.3000405@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2012 10:49 AM, Shawn Guo wrote:
> The property clock-frequency is optional for device tree probe.  When
> it's absent, the flexcan driver will try to get the frequency from clk
> system by calling clk_get_rate.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

As Oliver pointed out, this doesn't go through the net tree.

Marc

> ---
>  .../devicetree/bindings/net/can/fsl-flexcan.txt    |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> index f31b686..8ff324e 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> @@ -11,6 +11,9 @@ Required properties:
>  
>  - reg : Offset and length of the register set for this device
>  - interrupts : Interrupt tuple for this device
> +
> +Optional properties:
> +
>  - clock-frequency : The oscillator frequency driving the flexcan device
>  
>  Example:


-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/063fb563/attachment.sig>
