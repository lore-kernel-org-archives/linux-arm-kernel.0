From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 22 Dec 2010 22:17:34 +0300
Subject: [PATCH] davinci: Support various speedgrades for MityDSP-L138
	and MityARM-1808 SoMs
In-Reply-To: <1293039999-20239-1-git-send-email-michael.williamson@criticallink.com>
References: <1293039999-20239-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <4D124ECE.8030900@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Michael Williamson wrote:

> For the MityDSP-L138/MityARM-1808 SoMs, the speed grade can be determined
> from the part number string read from the factory configuration block on
> the on-board I2C PROM.  Configure the maximum CPU speed based on this
> information.

> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
[...]

> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
> index 0bb5f0c..9d30c01 100644
> --- a/arch/arm/mach-davinci/board-mityomapl138.c
> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
> @@ -44,38 +44,102 @@ struct factory_config {
>  
>  static struct factory_config factory_config;
>  
> +struct part_no_info {
> +	const char	*part_no;  /* part number string of interest */
> +	int		max_freq; /* khz */

    Why not align the comments (and do it with a tab)?

WBR, Sergei
