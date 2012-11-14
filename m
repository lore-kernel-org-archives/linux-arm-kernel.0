From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 14 Nov 2012 14:17:13 +0400
Subject: [PATCH v3 2/6] ARM: davinci: Changed pr_warning() to pr_warn()
 (part 2)
In-Reply-To: <1352853207-20602-2-git-send-email-rtivy@ti.com>
References: <1352853207-20602-1-git-send-email-rtivy@ti.com>
 <1352853207-20602-2-git-send-email-rtivy@ti.com>
Message-ID: <50A36FA9.5050601@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 14-11-2012 4:33, Robert Tivy wrote:

> Also, while modifying those pr_warning() calls I changed hardcoded
> function names to use '"%s:", __func__' instead

> Signed-off-by: Robert Tivy <rtivy@ti.com>
> ---
> Clean up files that will be otherwise modified in subsequent patch.

> Applies to v3.7-rc2 tag (commit 6f0c0580b70c89094b3422ba81118c7b959c7556) of
> Linus' mainline kernel at git.kernel.org.

>   arch/arm/mach-davinci/board-omapl138-hawk.c |   30 ++++++++++-----------------
>   1 file changed, 11 insertions(+), 19 deletions(-)

    Taksing of separation of board and SoC specific changes, this patch 
shouldn't have been separated from patch 1 at all -- since it's two boards 
built around the same chip, OMAP-L138...

> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
> index dc1208e..8aea169 100644
> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
> @@ -48,8 +48,7 @@ static __init void omapl138_hawk_config_emac(void)
>   	val &= ~BIT(8);
>   	ret = davinci_cfg_reg_list(omapl138_hawk_mii_pins);
>   	if (ret) {
> -		pr_warning("%s: cpgmac/mii mux setup failed: %d\n",
> -			__func__, ret);
> +		pr_warn("%s: cpgmac/mii mux setup failed: %d\n", __func__, ret);

    I'd have preferred this as "CPGMAC/MII". Almost all other acronyms in the 
messages are capitalized.

>   		return;
>   	}
>
> @@ -61,8 +60,7 @@ static __init void omapl138_hawk_config_emac(void)
>
>   	ret = da8xx_register_emac();
>   	if (ret)
> -		pr_warning("%s: emac registration failed: %d\n",
> -			__func__, ret);
> +		pr_warn("%s: emac registration failed: %d\n", __func__, ret);

    ... and "EMAC" here.

WBR, Sergei
