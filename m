From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 4 Nov 2018 13:13:14 +0100
Subject: [PATCH 09/11] dt-bindings: spi/spi-pxa2xx: Add ready GPIO signal
In-Reply-To: <20181010170936.316862-10-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-10-lkundrak@v3.sk>
Message-ID: <20181104121314.GU23864@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-10-10 19:09:34, Lubomir Rintel wrote:
> This this is used to let the SPI master know that our FIFO is filled and
> we're ready to service a transfer. Only useful in slave mode.
> 
> A signal like this is used by an embedded controller on a OLPC XO 1.75
> machine, that happens to be a SPI master.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  Documentation/devicetree/bindings/spi/spi-pxa2xx.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
> index 89b2832283e3..681a82b40e6f 100644
> --- a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
> @@ -12,6 +12,8 @@ Optional properties:
>  - cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
>    Documentation/devicetree/bindings/spi/spi-bus.txt
>  - spi-slave: Empty property indicating the SPI controller is used in slave mode.
> +- ready-gpio: GPIO used to signal a SPI master that the FIFO is filled
> +  and we're ready to service a transfer. Only useful in slave mode.
>  
>  Child nodes represent devices on the SPI bus
>    See ../spi/spi-bus.txt

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181104/00132253/attachment.sig>
