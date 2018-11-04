From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 4 Nov 2018 13:26:36 +0100
Subject: [PATCH 03/15] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC
 bindings
In-Reply-To: <20181010172300.317643-4-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-4-lkundrak@v3.sk>
Message-ID: <20181104122636.GX23864@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-10-10 19:22:48, Lubomir Rintel wrote:
> The OLPC XO-1.75 Embedded Controller is a SPI master that uses extra
> signals for handshaking. It needs to know when is the slave (Linux)
> side's TX FIFO ready for transfer (the ready-gpio signal on the SPI
> controller node) and when does it wish to respond with a command (the
> cmd-gpio property).
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>


> ---
>  .../bindings/misc/olpc,xo1.75-ec.txt          | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> new file mode 100644
> index 000000000000..14385fee65d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> @@ -0,0 +1,24 @@
> +OLPC XO-1.75 Embedded Controller
> +
> +Required properties:
> +- compatible: Should be "olpc,xo1.75-ec".
> +- cmd-gpio: gpio specifier of the CMD pin
> +
> +The embedded controller requires the SPI controller driver to signal readiness
> +to receive a transfer (that is, when TX FIFO contains the response data) by
> +strobing the ACK pin with the ready signal. See the "ready-gpio" property of the
> +SSP binding as documented in:
> +<Documentation/devicetree/bindings/spi/spi-pxa2xx.txt>.
> +
> +Example:
> +	&ssp3 {
> +		spi-slave;
> +		status = "okay";
> +		ready-gpio = <&gpio 125 GPIO_ACTIVE_HIGH>;
> +
> +		slave {
> +			compatible = "olpc,xo1.75-ec";
> +			spi-cpha;
> +			cmd-gpio = <&gpio 155 GPIO_ACTIVE_HIGH>;
> +		};
> +	};

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181104/8e0f173c/attachment.sig>
