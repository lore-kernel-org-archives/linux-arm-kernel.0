From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Tue, 11 Oct 2011 12:21:15 +0200
Subject: [PATCH v3 1/6] iommu/core: split mapping to page sizes as
	supported by the hardware
In-Reply-To: <CAK=WgbbXpqfrYYU4Or_q_ZtYzF9dH41hT+zXhB9-4pKjYFjK8w@mail.gmail.com>
References: <CAK=WgbahwY+7Ux-RjW2Tw9WBSwZnYuTMZ2NQASWyOXQ3zF6qFg@mail.gmail.com>
	<20110927131222.GL2138@amd.com>
	<CAK=WgbYG2tpMJ2SikZhm=R9j5kQ6Hm8CGg=q1bko3idzF53Q3Q@mail.gmail.com>
	<20110927181438.GM2138@amd.com>
	<CAK=WgbbNs5fWHDEputZ=jzU5YN0sn0tf6AETkcsoq_Jbvc2XgQ@mail.gmail.com>
	<20111010094738.GW2138@amd.com>
	<CAK=WgbZ7Wyax1yfS1jSXw9OdwMtxxidwLO8PTsNUXX9CWzmVrw@mail.gmail.com>
	<20111010153609.GB2138@amd.com>
	<CAK=WgbYR_qx53Z7s3R=q29KYo8ebYCH9H9=2OrrWXWMv6=-iOQ@mail.gmail.com>
	<CAK=WgbbXpqfrYYU4Or_q_ZtYzF9dH41hT+zXhB9-4pKjYFjK8w@mail.gmail.com>
Message-ID: <20111011102115.GE2138@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 06:01:06PM -0400, Ohad Ben-Cohen wrote:
> > On Mon, Oct 10, 2011 at 5:36 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> >> The master branch is best to base your patches on for generic work.
> 
> It looks like the master branch is missing something like this:
> 
> >From acb316aa4bcaf383e8cb1580e30c8635e0a34369 Mon Sep 17 00:00:00 2001
> From: Ohad Ben-Cohen <ohad@wizery.com>
> Date: Mon, 10 Oct 2011 23:55:51 +0200
> Subject: [PATCH] iommu/core: fix build issue
> 
> Fix this:
> 
> drivers/iommu/iommu.c: In function 'iommu_commit':
> drivers/iommu/iommu.c:291: error: 'iommu_ops' undeclared (first use in
> this function)
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  drivers/iommu/iommu.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 909b0d2..a5131f1 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -288,7 +288,7 @@ EXPORT_SYMBOL_GPL(iommu_unmap);
> 
>  void iommu_commit(struct iommu_domain *domain)
>  {
> -	if (iommu_ops->commit)
> -		iommu_ops->commit(domain);
> +	if (domain->ops->commit)
> +		domain->ops->commit(domain);
>  }
>  EXPORT_SYMBOL_GPL(iommu_commit);
> -- 
> 1.7.4.1

Whoops. This iommu_commit branch wasn't meant to be in master already.
I'll try to fix that.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
