From: eric.auger@redhat.com (Auger Eric)
Date: Thu, 16 Mar 2017 09:58:53 +0100
Subject: [RFC PATCH 16/33] irqchip/gic-v3-its: Add GICv4 ITS command
 definitions
In-Reply-To: <1484648454-21216-17-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-17-git-send-email-marc.zyngier@arm.com>
Message-ID: <01036799-4239-0c0c-4100-3a8e3afafa3e@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 17/01/2017 11:20, Marc Zyngier wrote:
> Add the new GICv4 ITS command definitions, most of them, being
> defined in terms of their physical counterparts.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/linux/irqchip/arm-gic-v3.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index dc7dcc6..1b3a070 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -338,6 +338,18 @@
>  #define GITS_CMD_SYNC			0x05
>  
>  /*
> + * GICv4 ITS specific commands
> + */
> +#define GITS_CMD_GICv4(x)		((x) | 0x20)
> +#define GITS_CMD_VINVALL		GITS_CMD_GICv4(GITS_CMD_INVALL)
> +#define GITS_CMD_VMAPP			GITS_CMD_GICv4(GITS_CMD_MAPC)
> +#define GITS_CMD_VMAPTI			GITS_CMD_GICv4(GITS_CMD_MAPTI)
> +#define GITS_CMD_VMOVI			GITS_CMD_GICv4(GITS_CMD_MOVI)
> +#define GITS_CMD_VSYNC			GITS_CMD_GICv4(GITS_CMD_SYNC)
> +/* VMOVP is the odd one, as it doesn't have a physical counterpart */
> +#define GITS_CMD_VMOVP			GITS_CMD_GICv4(2)
> +
> +/*
>   * ITS error numbers
>   */
>  #define E_ITS_MOVI_UNMAPPED_INTERRUPT		0x010107
> 
