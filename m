From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 Jul 2016 10:12:18 +0200 (CEST)
Subject: [PATCH v11 06/10] genirq/msi-doorbell: msi_doorbell_safe
In-Reply-To: <1468933367-23159-7-git-send-email-eric.auger@redhat.com>
References: <1468933367-23159-1-git-send-email-eric.auger@redhat.com>
 <1468933367-23159-7-git-send-email-eric.auger@redhat.com>
Message-ID: <alpine.DEB.2.11.1607201010350.3564@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Jul 2016, Eric Auger wrote:
> +bool msi_doorbell_safe(void)
> +{
> +	struct irqchip_doorbell *db;
> +	bool irq_remapping = true;
> +
> +	mutex_lock(&irqchip_doorbell_mutex);
> +	list_for_each_entry(db, &irqchip_doorbell_list, next) {
> +		irq_remapping &= db->info.irq_remapping;

db->info.irq_remapping is set in msi_doorbell_register(). So you can keep book
about that there. No need to iterate here.

Thanks,

	tglx
