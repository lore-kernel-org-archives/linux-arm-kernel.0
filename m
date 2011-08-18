From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Aug 2011 15:35:42 +0200
Subject: [PATCH 1/7] omap: iommu: migrate to the generic IOMMU API
In-Reply-To: <201108181101.57882.laurent.pinchart@ideasonboard.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
	<1313622608-30397-2-git-send-email-ohad@wizery.com>
	<201108181101.57882.laurent.pinchart@ideasonboard.com>
Message-ID: <201108181535.42339.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 August 2011, Laurent Pinchart wrote:
> > +static int omap_iommu_domain_init(struct iommu_domain *domain)
> > +{
> > +     struct omap_iommu_domain *omap_domain;
> > +
> > +     omap_domain = kzalloc(sizeof(*omap_domain), GFP_KERNEL);
> > +     if (!omap_domain) {
> > +             pr_err("kzalloc failed\n");
> > +             goto out;
> 
> You can directly return -ENOMEM here, and remove the "out:" label.

Risking to get into bike-shedding here, I would comment that the current
code is actually better. I would not mix the two methods of error handling
in one function. If you use goto labels, better use them consistenly and
have only one 'return' statement.

	Arnd
