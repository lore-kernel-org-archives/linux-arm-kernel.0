From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 17 Sep 2010 17:34:34 +0400
Subject: [PATCH v2] davinci: MityDSP-L138/MityARM-1808 read MAC address
	from I2C Prom
In-Reply-To: <1284673716-4848-1-git-send-email-michael.williamson@criticallink.com>
References: <1284673716-4848-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <4C936E6A.2040701@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Michael Williamson wrote:

> For the MityDSP-L138/MityARM-1808 SOMS, read the factory assigned
> MAC address from the onboard I2C EPROM and assign it to the emac
> device during platform initialization.

> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>

[...]

> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
> index 6f12a18..1fff0bb 100644
> --- a/arch/arm/mach-davinci/board-mityomapl138.c
> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
> @@ -15,6 +15,8 @@
[...]
> +static void read_factory_config(struct memory_accessor *a, void *context)
> +{
[...]
> +	if (is_valid_ether_addr(factory_config.mac))
> +		memcpy(&soc_info->emac_pdata->mac_addr[0],

    & and [0] are not needed.

> +			&factory_config.mac[0], ETH_ALEN);

    Same here.

WBR, Sergei
