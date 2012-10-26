From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 26 Oct 2012 13:46:27 +0400
Subject: [PATCH v2 1/6] ARM: davinci: Changed pr_warning() to pr_warn()
In-Reply-To: <1351197357-23528-1-git-send-email-rtivy@ti.com>
References: <1351197357-23528-1-git-send-email-rtivy@ti.com>
Message-ID: <508A5BF3.2060803@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

    It's not a good idea to send multiple patches with the same subject. 
Actually, in this case it's worth merging all 4 patches into one.

On 26-10-2012 0:35, Robert Tivy wrote:

> Also, while modifying those pr_warning() calls I changed hardcoded
> function names to use '"%s:", __func__' instead

> Signed-off-by: Robert Tivy <rtivy@ti.com>
> ---
> Clean up files that will be otherwise modified in subsequent patch.

> Applies to v3.5 tag (commit 28a33cbc24e4256c143dce96c7d93bf423229f92) of
> Linus' mainline kernel at git.kernel.org.

    3.5 is too old. Why not to 3.6 or even 3.7-rc2?

> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index 0149fb4..bbb3c73 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
[...]
> @@ -1046,21 +1046,19 @@ static int __init da850_evm_config_emac(void)
>  	}
>
>  	if (ret)
> -		pr_warning("da850_evm_init: cpgmac/rmii mux setup failed: %d\n",
> -				ret);
> +		pr_warn("%s: cpgmac/rmii mux setup failed: %d\n",
> +			__func__, ret);
>
>  	/* configure the CFGCHIP3 register for RMII or MII */
>  	__raw_writel(val, cfg_chip3_base);
>
>  	ret = davinci_cfg_reg(DA850_GPIO2_6);
>  	if (ret)
> -		pr_warning("da850_evm_init:GPIO(2,6) mux setup "
> -							"failed\n");
> +		pr_warn("%s:GPIO(2,6) mux setup failed\n", __func__);

    Worth inserting space after colon here.

WBR, Sergei
