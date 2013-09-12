From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Sep 2013 15:54:17 -0500
Subject: [RFC PATCH 1/4] DRIVERS: IRQCHIP: Add crossbar irqchip driver
In-Reply-To: <1379000351-15672-2-git-send-email-r.sricharan@ti.com>
References: <1379000351-15672-1-git-send-email-r.sricharan@ti.com>
 <1379000351-15672-2-git-send-email-r.sricharan@ti.com>
Message-ID: <20130912205417.GA539@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 09:09:08PM +0530, Sricharan R wrote:
> +unsigned int crossbar_request_irq(struct irq_data *d)
> +{
> +	int cb_no = d->hwirq;
> +	int virq = allocate_free_irq(cb_no);
> +	void *irq = &cb->crossbar_map[cb_no].hwirq;
> +	int err;
> +
> +	err = request_threaded_irq(virq, crossbar_irq, NULL,
> +				   0, "CROSSBAR", irq);

this is wrong, why don't you just set crossbar up as a chained handler.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130912/1911b759/attachment.sig>
