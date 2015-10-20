From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 20 Oct 2015 17:52:58 +0200
Subject: [PATCH V5 1/6] i2c: Add i2c support to Freescale Layerscape
 platforms
In-Reply-To: <1445255774-32887-1-git-send-email-B48286@freescale.com>
References: <1445255774-32887-1-git-send-email-B48286@freescale.com>
Message-ID: <20151020155258.GM5379@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 07:56:09PM +0800, Zhiqiang Hou wrote:
> From: Shaohui Xie <Shaohui.Xie@freescale.com>
> 
> Modify the I2C_IMX config to support to Layerscape platforms.
> 
> Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
> Signed-off-by: Wenbin Song <Wenbin.Song@freescale.com>
> Signed-off-by: Hou Zhiqiang <B48286@freescale.com>

Three signed offs for a simple Kconfig change? And the person doing
the patch has no signed off?? That looks wrong. Maybe the above signed
offs should be acked by?

> ---
> V5: V4 V3 V2
>  - No change.
> 
>  drivers/i2c/busses/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 08b8617..14147ec 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -582,10 +582,10 @@ config I2C_IMG
>  
>  config I2C_IMX
>  	tristate "IMX I2C interface"
> -	depends on ARCH_MXC
> +	depends on ARCH_MXC || ARCH_LAYERSCAPE
>  	help
>  	  Say Y here if you want to use the IIC bus controller on
> -	  the Freescale i.MX/MXC processors.
> +	  the Freescale i.MX/MXC or Layerscape processors.
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-imx.
> -- 
> 2.1.0.27.g96db324
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151020/6472d8cb/attachment.sig>
