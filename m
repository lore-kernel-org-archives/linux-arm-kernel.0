From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 14 Feb 2017 11:02:59 -0600
Subject: [PATCH 3/5] devicetree: bindings: revise compatible string of
 sprd uart
In-Reply-To: <1487063952-7113-4-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1487063952-7113-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1487063952-7113-4-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <CAL_JsqKNfYSug4vd5uWXnxn-_z0e-Nk9TYkktudk+F1VBYcm8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 3:19 AM, Chunyan Zhang
<chunyan.zhang@spreadtrum.com> wrote:
> This patch revise the compatible string of sprd uart to "sc-uart"
> since this driver is not only for SC9836, but for all Spreadtrum
> SoCs so far.
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---
>  Documentation/devicetree/bindings/serial/sprd-uart.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
> index 2aff0f2..9b0ad52 100644
> --- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/sprd-uart.txt
> @@ -1,7 +1,7 @@
>  * Spreadtrum serial UART
>
>  Required properties:
> -- compatible: must be "sprd,sc9836-uart"
> +- compatible: must be "sprd,sc-uart"

You can't just change compatible strings.

You don't need a generic-ish compatible if other SoCs have "the same"
uart. Then you just do: '"sprd,sc<new soc>-uart", "sprd,sc9836-uart"'
in the DT. The existing driver will work matching on sprd,sc9836-uart
and if you ever find some difference in the uarts you have the more
specific compatible string to handle that.

Rob
