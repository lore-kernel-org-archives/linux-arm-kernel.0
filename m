From: mark.rutland@arm.com (Mark Rutland)
Date: Sat, 10 Aug 2013 13:50:15 +0100
Subject: [PATCH v4 2/2] i2c: designware: add two optional property
 tx/rx-fifo-size
In-Reply-To: <1374844938-25505-3-git-send-email-zhangfei.gao@linaro.org>
References: <1374844938-25505-1-git-send-email-zhangfei.gao@linaro.org>
 <1374844938-25505-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20130810125015.GB18085@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 02:22:18PM +0100, Zhangfei Gao wrote:
> Some platform can not get fifo-size info form register DW_IC_COMP_PARAM_1.

s/form/from/

Why can they not get info from the register? Is it not implemented, or
buggy? It would be nice to mention why.

> Give chance to update rx-fifo-size and tx-fifo-size if provided in dts.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Acked-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  .../devicetree/bindings/i2c/i2c-designware.txt     |    7 +++++++
>  drivers/i2c/busses/i2c-designware-platdrv.c        |    3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> index 7fd7fa2..af0bf8f 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> @@ -6,6 +6,11 @@ Required properties :
>   - reg : Offset and length of the register set for the device
>   - interrupts : <IRQ> where IRQ is the interrupt number.
>  
> +Optional properties:
> +
> + - rx-fifo-size : 1 cell, Rx fifo size
> + - tx-fifo-size : 1 cell, Tx fifo size

Units? I assume these are in bytes?

It would be nice to mention in the bidning when you need these
properties (i.e. only hwen you can't figure it out from
DW_IC_COMP_PARAM_1 becase ________.

Thanks,
Mark.
