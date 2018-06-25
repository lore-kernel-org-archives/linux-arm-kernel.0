From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 25 Jun 2018 10:16:38 +0200
Subject: [PATCH] dt-bindings: serial: imx: clarify rs485 support usage
In-Reply-To: <01fc1e3d89037adce38177c3922d277584214fdd.1529911999.git.baruch@tkos.co.il>
References: <01fc1e3d89037adce38177c3922d277584214fdd.1529911999.git.baruch@tkos.co.il>
Message-ID: <20180625101638.47f3b3dd@karo-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 25 Jun 2018 10:33:19 +0300 Baruch Siach wrote:
> The i.MX UART peripheral uses the RST_B signal as input, and CTS_B as
> output. This is just like the CDE role in RS-232. This is true
>
s/CDE/DCE/

> regardless of the "DTE mode" setting of this peripheral.
> 
> As a result, rs485 support hardware must use the CTS_B signal to control
> the RS-485 transceiver. This is in contrast to generic rs485 kernel
> code, documentation, and DT property names that consistently refer to
> the RST as transceiver control signal.
>
s/RST/RTS/

> Add a note in the DT binding document about that, to reduce the
> confusion somewhat.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  Documentation/devicetree/bindings/serial/fsl-imx-uart.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
> index afcfbc34e243..35957cbf1571 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
> @@ -9,7 +9,11 @@ Optional properties:
>  - fsl,dte-mode : Indicate the uart works in DTE mode. The uart works
>                    in DCE mode by default.
>  - rs485-rts-delay, rs485-rts-active-low, rs485-rx-during-tx,
> -  linux,rs485-enabled-at-boot-time: see rs485.txt
> +  linux,rs485-enabled-at-boot-time: see rs485.txt. Note that for RS485
> +  you must enable either the "uart-has-rtscts" or the "rts-gpios"
> +  properties. In case you use "uart-has-rtscts" the signal that controls
> +  the transceiver is actually CTS_B, not RTS_B. CTS_B is always output,
> +  and RTS_B is input, regardless of dte-mode.
>  
>  Please check Documentation/devicetree/bindings/serial/serial.txt
>  for the complete list of generic properties.


Lothar Wa?mann
