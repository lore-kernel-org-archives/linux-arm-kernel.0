From: robherring2@gmail.com (Rob Herring)
Date: Mon, 27 Jul 2015 08:35:53 -0500
Subject: [RESEND PATCH v2 1/2] dt: snps, dw-apb-ssi: Document new I/O data
 register width property
In-Reply-To: <1437997035-3046-2-git-send-email-michael@smart-africa.com>
References: <1435163696-14767-1-git-send-email-michael@smart-africa.com>
 <1437997035-3046-1-git-send-email-michael@smart-africa.com>
 <1437997035-3046-2-git-send-email-michael@smart-africa.com>
Message-ID: <CAL_JsqKwO0__jT_c8dYsp-LoreoTdC+_qmjj_s-UqGPfSrxdzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 6:37 AM, Michael van der Westhuizen
<michael@smart-africa.com> wrote:
> This change documents a new property for the snps,dw-apb-ssi device,
> allowing an implementer to specify either four byte or two bytes
> access to the SPI controller data register.
>
> This supports a change that unbreaks this driver on picoXcell
> platforms.
>
> Signed-off-by: Michael van der Westhuizen <michael@smart-africa.com>
> ---
>
> Changes in v2:
>   - Incorporate review feedback from Andy Shevchenko, reworking the
>     bindings to reflect common practice.
>
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> index bd99193..b4f1086 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> @@ -10,6 +10,8 @@ Required properties:
>  Optional properties:
>  - cs-gpios : Specifies the gpio pis to be used for chipselects.
>  - num-cs : The number of chipselects. If omitted, this will default to 4.
> +- snps,reg-io-width : The I/O register width (in bytes) implemented by
> +  this device.  Supported values are 2 or 4 (the default).

Drop the snps as this is already a common property (at least for UARTs).

Rob
