From: b.brezillon@overkiz.com (boris brezillon)
Date: Thu, 09 Jan 2014 13:23:58 +0100
Subject: [PATCH] at91: smc: bug fix in sam9_smc_cs_read()
In-Reply-To: <1389268187-23585-1-git-send-email-jjhiblot@traphandler.com>
References: <1389268187-23585-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <52CE94DE.40604@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2014 12:49, Jean-Jacques Hiblot wrote:
> There was a copy/paste error when reading the nwe_pulse value.
>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Acked-by: Boris BREZILLON <b.brezillon@overkiz.com>
> ---
>   arch/arm/mach-at91/sam9_smc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-at91/sam9_smc.c b/arch/arm/mach-at91/sam9_smc.c
> index 99a0a1d..b26156b 100644
> --- a/arch/arm/mach-at91/sam9_smc.c
> +++ b/arch/arm/mach-at91/sam9_smc.c
> @@ -101,7 +101,7 @@ static void sam9_smc_cs_read(void __iomem *base,
>   	/* Pulse register */
>   	val = __raw_readl(base + AT91_SMC_PULSE);
>   
> -	config->nwe_setup = val & AT91_SMC_NWEPULSE;
> +	config->nwe_pulse = val & AT91_SMC_NWEPULSE;
>   	config->ncs_write_pulse = (val & AT91_SMC_NCS_WRPULSE) >> 8;
>   	config->nrd_pulse = (val & AT91_SMC_NRDPULSE) >> 16;
>   	config->ncs_read_pulse = (val & AT91_SMC_NCS_RDPULSE) >> 24;
