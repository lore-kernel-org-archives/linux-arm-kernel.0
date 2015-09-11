From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 11 Sep 2015 21:06:19 +0200
Subject: [PATCH-v5 RESEND 3/5] i2c: pxa: Add support for pxa910/988 & new
 configuration features
In-Reply-To: <1440395978-9065-4-git-send-email-vaibhav.hiremath@linaro.org>
References: <1440395978-9065-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440395978-9065-4-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150911190619.GB1516@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 11:29:36AM +0530, Vaibhav Hiremath wrote:
> TWSI_ILCR & TWSI_IWCR registers are used to adjust clock rate
> of standard & fast mode in pxa910/988; so this patch adds these two new
> entries to "struct pxa_reg_layout" and "struct pxa_i2c".
> 
> As discussed in the previous patch-series, the idea here is to add standard
> DT properties for ilcr and iwcr configuration fields.
> In case of Master ilcr is used for low/high time and in case of slave mode
> of operation iwcr is used for setup/hold time.

I need to rethink how to describe i2c bus timing parameters in DT in the
next days. But this is planned for 4.4., promised.

One thing I already wonder about this one...

>  static const struct platform_device_id i2c_pxa_id_table[] = {
>  	{ "pxa2xx-i2c",		REGS_PXA2XX },
>  	{ "pxa3xx-pwri2c",	REGS_PXA3XX },
>  	{ "ce4100-i2c",		REGS_CE4100 },
> +	{ "pxa910-i2c",		REGS_PXA910 },
>  	{ },

You add a new platform_id...

> @@ -1135,7 +1170,7 @@ static const struct i2c_algorithm i2c_pxa_pio_algorithm = {
>  static const struct of_device_id i2c_pxa_dt_ids[] = {
>  	{ .compatible = "mrvl,pxa-i2c", .data = (void *)REGS_PXA2XX },
>  	{ .compatible = "mrvl,pwri2c", .data = (void *)REGS_PXA3XX },
> -	{ .compatible = "mrvl,mmp-twsi", .data = (void *)REGS_PXA2XX },
> +	{ .compatible = "mrvl,mmp-twsi", .data = (void *)REGS_PXA910 },
>  	{}

...but change the compatible binding instead of adding a new one?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150911/386187f5/attachment.sig>
