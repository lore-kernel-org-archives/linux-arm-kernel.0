From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 02 Feb 2011 15:08:12 +0300
Subject: [PATCH v1 9/9] da850: pruss CAN platform specific changes for
	gpios.
In-Reply-To: <1296571667-12049-10-git-send-email-subhasish@mistralsolutions.com>
References: <1296571667-12049-1-git-send-email-subhasish@mistralsolutions.com>
	<1296571667-12049-10-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <4D49492C.1000303@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01-02-2011 17:47, Subhasish Ghosh wrote:

> This patch adds the GPIOs for the pruss CAN device.

> Signed-off-by: Subhasish Ghosh<subhasish@mistralsolutions.com>
[...]

> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 11ce7ba..9382b4f 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -570,6 +570,7 @@ static const struct mux_config da850_pins[] = {
>   	MUX_CFG(DA850, PRUSS_PRU1_R30_15,	12,	0,	15,	4,	false)
>   	MUX_CFG(DA850, PRUSS_PRU1_R31_18,	11,	20,	15,	0,	false)
>   	/* GPIO function */
> +	MUX_CFG(DA850, GPIO2_0,		6,	28,	15,	8,	false)
>   	MUX_CFG(DA850, GPIO2_4,		6,	12,	15,	8,	false)
>   	MUX_CFG(DA850, GPIO2_6,		6,	4,	15,	8,	false)
>   	MUX_CFG(DA850, GPIO2_8,		5,	28,	15,	8,	false)
> diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
> index 10f49f2..85b3a0d 100644
> --- a/arch/arm/mach-davinci/include/mach/mux.h
> +++ b/arch/arm/mach-davinci/include/mach/mux.h
> @@ -912,6 +912,7 @@ enum davinci_da850_index {
>   	DA850_PRUSS_PRU1_R31_18,
>
>   	/* GPIO function */
> +	DA850_GPIO2_0,
>   	DA850_GPIO2_4,
>   	DA850_GPIO2_6,
>   	DA850_GPIO2_8,

    Should again precede the previous patch. I thought that must be obvious...

WBR, Sergei
