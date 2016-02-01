From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 1 Feb 2016 12:25:14 +0100
Subject: [PATCH V4 11/11] soc: mediatek: PMIC wrap: add MT2701/7623 support
In-Reply-To: <1453894149-44127-11-git-send-email-blogic@openwrt.org>
References: <1453894149-44127-1-git-send-email-blogic@openwrt.org>
 <1453894149-44127-11-git-send-email-blogic@openwrt.org>
Message-ID: <56AF409A.2040705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/01/16 12:29, John Crispin wrote:

[...]

>
> +static int pwrap_mt2701_init_reg_clock(struct pmic_wrapper *wrp)
> +{
> +	switch (wrp->slave->type) {
> +	case PMIC_MT6397:
> +		pwrap_writel(wrp, 0xc, PWRAP_RDDMY);
> +		pwrap_writel(wrp, 0x4, PWRAP_CSHEXT_WRITE);
> +		pwrap_writel(wrp, 0x0, PWRAP_CSHEXT_READ);
> +		pwrap_writel(wrp, 0x2, PWRAP_CSLEXT_START);
> +		pwrap_writel(wrp, 0x2, PWRAP_CSLEXT_END);
> +		break;
> +
> +	case PMIC_MT6323:
> +		pwrap_writel(wrp, 0x8, PWRAP_RDDMY);
> +		pwrap_dew_write(wrp, PWRAP_DEW_RDDMY_NO, 0x8);
> +		pwrap_writel(wrp, 0x5, PWRAP_CSHEXT_WRITE);
> +		pwrap_writel(wrp, 0x0, PWRAP_CSHEXT_READ);
> +		pwrap_writel(wrp, 0x2, PWRAP_CSLEXT_START);
> +		pwrap_writel(wrp, 0x2, PWRAP_CSLEXT_END);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +

I forgot this:
So mt2701 can be used with both PMICs? Just wondering, as from what I 
know, SoC and PMIC a tightly coupled.

In general this series looks quite good to me.

Regards,
Matthias
