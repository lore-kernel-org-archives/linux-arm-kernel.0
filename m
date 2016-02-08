From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 8 Feb 2016 10:53:22 +0100
Subject: [PATCH 1/6] irqchip: add the Alpine MSIX interrupt controller
In-Reply-To: <56B86391.1030609@arm.com>
References: <1454922971-17405-1-git-send-email-antoine.tenart@free-electrons.com>
 <1454922971-17405-2-git-send-email-antoine.tenart@free-electrons.com>
 <56B86391.1030609@arm.com>
Message-ID: <20160208105322.78b20cba@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marc,

On Mon, 8 Feb 2016 09:44:49 +0000, Marc Zyngier wrote:

> > +static struct msi_domain_info alpine_msix_domain_info = {
> > +	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> > +		  MSI_FLAG_PCI_MSIX,
> 
> You can probably add MSI_FLAG_PCI_MSI, it should work as well (MULTI_MSI
> obviously won't).

Why wouldn't MULTI_MSI work? The code is using
bitmap_find_next_zero_area() in alpine_msix_allocate_sgi() precisely to
find num_req consecutive bits set to 0, in order to allocate multiple
MSIs at once. Am I missing something?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
