From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 10 Jul 2015 10:13:27 +0200
Subject: [PATCH-v3 04/11] i2c: pxa: Remove compile warnning in 64bit mode
In-Reply-To: <1436210695-19159-5-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436210695-19159-5-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150710081327.GC1528@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 12:54:48AM +0530, Vaibhav Hiremath wrote:
> From: Yipeng Yao <ypyao@marvell.com>
> 
> Fix below warning message, coming from 64 bit toolchain.
> 
> drivers/i2c/busses/i2c-pxa.c:1237:15: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> 
> Signed-off-by: Yipeng Yao <ypyao@marvell.com>
> [vaibhav.hiremath at linaro.org: Updated Changelog]
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Huh? Why long? Shouldn't that be casted to enum pxa_i2c_types?

> ---
>  drivers/i2c/busses/i2c-pxa.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index 632008f..4c92694 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1116,7 +1116,9 @@ static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
>  		i2c->use_pio = 1;
>  	if (of_get_property(np, "mrvl,i2c-fast-mode", NULL))
>  		i2c->fast_mode = 1;
> -	*i2c_types = (u32)(of_id->data);
> +
> +	*i2c_types = (long)(of_id->data);
> +
>  	return 0;
>  }
>  
> -- 
> 1.9.1
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150710/64de08d1/attachment.sig>
