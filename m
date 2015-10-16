From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Fri, 16 Oct 2015 13:45:04 +0800
Subject: [PATCH RFC 4/7] genirq/msi: Make the .prepare callback reusable
In-Reply-To: <1444923568-17413-5-git-send-email-marc.zyngier@arm.com>
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
 <1444923568-17413-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <56208EE0.1030604@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/10/15 23:39, Marc Zyngier wrote:
<snit>
> +int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
> +			    int nvec, msi_alloc_info_t *arg)
> +{
> +	struct msi_domain_info *info = domain->host_data;
> +	struct msi_domain_ops *ops = info->ops;
> +	int ret;
> +
> +	ret = ops->msi_check(domain, info, dev);
> +	if (ret == 0)
> +		ret = ops->msi_prepare(domain, dev, nvec, arg);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
Seems a simple "return ret" is enough:)
