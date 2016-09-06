From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 6 Sep 2016 12:20:09 +0200 (CEST)
Subject: [PATCH V10 2/8] ACPI: Add new IORT functions to support MSI
 domain handling
In-Reply-To: <1473152938-17388-3-git-send-email-tn@semihalf.com>
References: <1473152938-17388-1-git-send-email-tn@semihalf.com>
 <1473152938-17388-3-git-send-email-tn@semihalf.com>
Message-ID: <alpine.DEB.2.20.1609061219230.5647@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Sep 2016, Tomasz Nowicki wrote:
> +/**
> + * iort_get_device_domain() - Find MSI domain related to a device
> + * @dev: The device.
> + * @req_id: Requester ID for the device.
> + *
> + * Returns: the MSI domain for this device, NULL otherwise
> + */
> +struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
> +{
> +	static struct fwnode_handle *handle;

static ??????

> +	int its_id;
> +
> +	if (iort_dev_find_its_id(dev, req_id, 0, &its_id))
> +		return NULL;
> +
> +	handle = iort_find_domain_token(its_id);

You reevaluate that on every call.

Thanks,

	tglx
