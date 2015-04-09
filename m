From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 09 Apr 2015 16:58:36 +0200
Subject: [PATCH 1/2] doc/bindings: Add 'endianess'
 optional-property for FlexCAN controller
In-Reply-To: <1428591087-12831-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1428591087-12831-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <5526939C.5090309@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2015 04:51 PM, Bhupesh Sharma wrote:
> This patch adds 'endianess' as the optional-property for
> describing the FlexCAN controller present on various FSL platforms.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> Signed-off-by: Sakar Arora <Sakar.Arora@freescale.com>
> ---
>  .../devicetree/bindings/net/can/fsl-flexcan.txt    |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> index 56d6cc3..0d5e668 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> @@ -18,6 +18,10 @@ Optional properties:
>  
>  - xceiver-supply: Regulator that powers the CAN transceiver
>  
> +- little-endian: If the FlexCAN IP on this SoC is little-endian, use
> +                 this property. By default it is assumed that the IP
> +                 is big-endian

Where's the code that's evaluating this property? On ARM little endian
is assumed so far, on powerpc (p1010) it's big endian.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150409/a1e76d34/attachment.sig>
