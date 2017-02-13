From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 11:48:10 +0100 (CET)
Subject: [RFC PATCH 24/33] irqchip/gic-v3-its: Add VPE scheduling
In-Reply-To: <1484648454-21216-25-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-25-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131146250.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:
> +static int its_vpe_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
> +{
> +	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
> +	struct its_cmd_info *info = vcpu_info;
> +	u64 val;
> +
> +	switch (info->cmd_type) {
> +	case SCHEDULE_VPE:
> +	{
> +		void * __iomem vlpi_base = gic_data_rdist_vlpi_base();

Moving the vlpi_base line on top of the fucntion spares you lines and
brackets. No point in having the same thing twice

Thanks,

	tglx
