From: balbi@ti.com (Felipe Balbi)
Date: Thu, 26 Dec 2013 14:01:06 -0600
Subject: [PATCH V5 2/4] DRIVERS: IRQCHIP: CROSSBAR: Add support for
 Crossbar IP
In-Reply-To: <1386066445-28245-3-git-send-email-r.sricharan@ti.com>
References: <1386066445-28245-1-git-send-email-r.sricharan@ti.com>
 <1386066445-28245-3-git-send-email-r.sricharan@ti.com>
Message-ID: <20131226200106.GA30559@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 03, 2013 at 03:57:23PM +0530, Sricharan R wrote:
> +static const struct of_device_id crossbar_match[] __initconst = {
> +	{ .compatible = "ti,irq-crossbar" },
> +	{}
> +};
> +
> +int irqcrossbar_init(void)
> +{
> +	struct device_node *np;
> +	np = of_find_matching_node(NULL, crossbar_match);
> +	if (!np)
> +		return -ENODEV;
> +
> +	crossbar_of_init(np);
> +	return 0;
> +}

instead, please use IRQCHIP_DECLARE() then you won't need to expose this
symbol to be used by arch/arm/ code.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131226/fba560a9/attachment.sig>
