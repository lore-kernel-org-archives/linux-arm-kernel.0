From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 9 Aug 2016 11:19:18 +0200 (CEST)
Subject: [PATCH v12 02/11] genirq/msi: msi_compose wrapper
In-Reply-To: <1470158617-7022-3-git-send-email-eric.auger@redhat.com>
References: <1470158617-7022-1-git-send-email-eric.auger@redhat.com>
 <1470158617-7022-3-git-send-email-eric.auger@redhat.com>
Message-ID: <alpine.DEB.2.20.1608091117250.5388@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Aug 2016, Eric Auger wrote:

> Currently the MSI message is composed by directly calling
> irq_chip_compose_msi_msg and erased by setting the memory to zero.
> 
> On some platforms, we will need to complexify this composition to
> properly handle MSI emission through IOMMU. Also we will need to track
> when the MSI message is erased.

I just can't find how you do that. After applying the series the

> +	if (erase)
> +		memset(msg, 0, sizeof(*msg));

branch is still just a memset(). The wrapper is fine for the compose side, but
having the extra argument just to wrap the memset() for no gain is silly.

Thanks,

	tglx
