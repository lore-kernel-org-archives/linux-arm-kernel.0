From: mark.rutland@arm.com (Mark Rutland)
Date: Sat, 10 Aug 2013 15:08:27 +0100
Subject: [PATCH v3 2/2] i2c: imx: Add Vybrid VF610 I2C controller support
In-Reply-To: <1375418648-22760-2-git-send-email-b35083@freescale.com>
References: <1375418648-22760-1-git-send-email-b35083@freescale.com>
 <1375418648-22760-2-git-send-email-b35083@freescale.com>
Message-ID: <20130810140827.GC18085@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 05:44:08AM +0100, Jingchang Lu wrote:
>   Add Freescale Vybrid VF610 I2C controller support to
> imx I2C driver framework.
>   Some operation is different from imx I2C controller.
> The register offset, the i2c clock divider value table,
> the module enabling(I2CR_IEN) which is just invert with imx,
> and the interrupt flag(I2SR) clearing opcode is w1c on VF610
> but w0c on imx.
> 
> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> Signed-off-by: Xiaochun Li <b41219@freescale.com>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
> changes in v3:
>   Using struct naming the i2c clock {div, regval} pair.
>   Using address shift handling registers address difference.
> 
> changes in v2:
>   Fix building section mismatch(es) warning.
> 
>  drivers/i2c/busses/i2c-imx.c | 146 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 122 insertions(+), 24 deletions(-)

[...]

> @@ -145,6 +233,7 @@ MODULE_DEVICE_TABLE(platform, imx_i2c_devtype);
>  static const struct of_device_id i2c_imx_dt_ids[] = {
>         { .compatible = "fsl,imx1-i2c", .data = &imx_i2c_devtype[IMX1_I2C], },
>         { .compatible = "fsl,imx21-i2c", .data = &imx_i2c_devtype[IMX21_I2C], },
> +       { .compatible = "fsl,vf610-i2c", .data = &imx_i2c_devtype[VF610_I2C], },
>         { /* sentinel */ }
>  };


That string doesn't seem to be documented anywhere (from a quick grep of
Documentation/devicetree), and there's no binding update included
here. It would be nice for that to be fixed :)

Thanks,
Mark.
