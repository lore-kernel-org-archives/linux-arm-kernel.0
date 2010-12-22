From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 22 Dec 2010 22:09:33 +0300
Subject: [PATCH] davinci: Add additional JTAG code for AM-1808 and
	OMAP-L138 Rev 2.0 SoCs
In-Reply-To: <1293039967-20165-1-git-send-email-michael.williamson@criticallink.com>
References: <1293039967-20165-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <4D124CED.8090603@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Michael Williamson wrote:

> The JTAG variant code for Rev-2.0 silicon of the OMAP-L138 has changed.
> In addition, the variant code for the AM-1808 SoC appears to match
> the Rev-2.0 code for the OMAP-L138.  Add an additional entry to support
> these chips.

> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
> ---
> There are two whitespace fix-ups that were needed to pass checkpatch.pl

   You mean for the file to pass the checkpatch.pl, not for your patch, I hope?

> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 78b5ae2..3f888b3 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
[...]
> @@ -814,7 +821,7 @@ static void da850_set_async3_src(int pllnum)
>  			WARN(ret, "DA850: unable to re-parent clock %s",
>  								clk->name);
>  		}
> -       }
> +	}
>  
>  	v = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
>  	if (pllnum)
> @@ -895,7 +902,7 @@ static const struct da850_opp da850_opp_96 = {
>  	.cvdd_max	= 1050000,
>  };
>  
> -#define OPP(freq) 		\
> +#define OPP(freq)	\
>  	{				\
>  		.index = (unsigned int) &da850_opp_##freq,	\
>  		.frequency = freq * 1000, \

    Please send the white space changes in another patch.

WBR, Sergei
