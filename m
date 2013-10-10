From: balbi@ti.com (Felipe Balbi)
Date: Thu, 10 Oct 2013 10:29:22 -0500
Subject: [PATCH 2/5] usb: gadget: s3c-hsotg: support configurable UTMI
 PHY width
In-Reply-To: <1381140752-312-3-git-send-email-matt.porter@linaro.org>
References: <1381140752-312-1-git-send-email-matt.porter@linaro.org>
 <1381140752-312-3-git-send-email-matt.porter@linaro.org>
Message-ID: <20131010152922.GF28375@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 06:12:29AM -0400, Matt Porter wrote:
> Extend dwc2 binding with an optional utmi phy width property.
> Enable the s3c-hsotg.c driver to use standard dwc2 binding
> and enable configuration of the UTMI phy width based on the
> property.
> 
> Signed-off-by: Matt Porter <matt.porter@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> ---
>  Documentation/devicetree/bindings/staging/dwc2.txt |  4 ++++
>  drivers/usb/gadget/s3c-hsotg.c                     | 18 +++++++++++++++++-
>  drivers/usb/gadget/s3c-hsotg.h                     |  1 +
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/staging/dwc2.txt b/Documentation/devicetree/bindings/staging/dwc2.txt
> index 1a1b7cf..fb6b8ee 100644
> --- a/Documentation/devicetree/bindings/staging/dwc2.txt
> +++ b/Documentation/devicetree/bindings/staging/dwc2.txt
> @@ -6,10 +6,14 @@ Required properties:
>  - reg : Should contain 1 register range (address and length)
>  - interrupts : Should contain 1 interrupt
>  
> +Optional properties:
> +- snps,phy-utmi-width: Must contain the UTMI data width (either 8 or 16)

isn't this available in any of the configuration registers ?

>  Example:
>  
>          usb at 101c0000 {
>                  compatible = "ralink,rt3050-usb, snps,dwc2";
>                  reg = <0x101c0000 40000>;
>                  interrupts = <18>;
> +		snps,phy-utmi-width = <8>;

indentation.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131010/6f24fc09/attachment.sig>
