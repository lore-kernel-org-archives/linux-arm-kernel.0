From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 22 Mar 2017 10:05:44 +0100
Subject: [RESEND PATCH v3 1/2] dt-bindings: i2c: Add Mediatek MT2701 i2c
 binding
In-Reply-To: <1489029185-21447-2-git-send-email-jun.gao@mediatek.com>
References: <1489029185-21447-1-git-send-email-jun.gao@mediatek.com>
 <1489029185-21447-2-git-send-email-jun.gao@mediatek.com>
Message-ID: <20170322090543.sxacnddn2o7stjnq@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 09, 2017 at 11:13:04AM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
> 
> Add MT2701 i2c binding to i2c-mt6577.txt and there is no need to
> modify i2c driver.
> 
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>

There is still the issue which Matthias Brugger pointed out on January,
24th: you need to describe the fallback compatibles.

> ---
>  .../devicetree/bindings/i2c/i2c-mt6577.txt         |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
> index 0ce6fa3..27dbbf9 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
> @@ -4,11 +4,12 @@ The Mediatek's I2C controller is used to interface with I2C devices.
>  
>  Required properties:
>    - compatible: value should be either of the following.
> -      (a) "mediatek,mt6577-i2c", for i2c compatible with mt6577 i2c.
> -      (b) "mediatek,mt6589-i2c", for i2c compatible with mt6589 i2c.
> -      (c) "mediatek,mt8127-i2c", for i2c compatible with mt8127 i2c.
> -      (d) "mediatek,mt8135-i2c", for i2c compatible with mt8135 i2c.
> -      (e) "mediatek,mt8173-i2c", for i2c compatible with mt8173 i2c.
> +	"mediatek,mt2701-i2c"
> +	"mediatek,mt6577-i2c"
> +	"mediatek,mt6589-i2c"
> +	"mediatek,mt8127-i2c"
> +	"mediatek,mt8135-i2c"
> +	"mediatek,mt8173-i2c"
>    - reg: physical base address of the controller and dma base, length of memory
>      mapped region.
>    - interrupts: interrupt number to the cpu.
> -- 
> 1.7.9.5
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170322/701862c6/attachment.sig>
