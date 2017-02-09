From: robh@kernel.org (Rob Herring)
Date: Wed, 8 Feb 2017 18:43:02 -0600
Subject: [PATCH v1 2/3] dt: Document for the ZTE zx296718 I2S controller
In-Reply-To: <1486389020-29432-2-git-send-email-baoyou.xie@linaro.org>
References: <1486389020-29432-1-git-send-email-baoyou.xie@linaro.org>
 <1486389020-29432-2-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170209004302.njyxhwq5d2kbai7n@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 06, 2017 at 09:50:19PM +0800, Baoyou Xie wrote:
> This patch documents the devicetree for the ZTE's zx296718
> I2S audio controller.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/zte,zx-i2s.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
> index 7e5aa6f..c405561 100644
> --- a/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
> @@ -1,10 +1,12 @@
>  ZTE ZX296702 I2S controller
>  
>  Required properties:
> - - compatible : Must be "zte,zx296702-i2s"
> + - compatible : Should include one of the following strings:
> +	"zte,zx296702-i2s","zte,zx296718-i2s".

One per line please.

>   - reg : Must contain I2S core's registers location and length
>   - clocks : Pairs of phandle and specifier referencing the controller's clocks.
> - - clock-names: "tx" for the clock to the I2S interface.
> + - clock-names: "tx" for the wclk, "pclk" for the pclk to the I2S interface.
> +	must contain pclk for zx296718 SoC.

I'd reword as "pclk is only present for zte,zx296718-i2s"

>   - dmas: Pairs of phandle and specifier for the DMA channel that is used by
>     the core. The core expects two dma channels for transmit.
>   - dma-names : Must be "tx" and "rx"
> -- 
> 2.7.4
> 
