From: joerg.roedel@amd.com (Joerg Roedel)
Date: Tue, 13 Mar 2012 11:00:24 +0100
Subject: [PATCH v11 3/3] iommu/exynos: Add iommu driver for Exynos
 Platforms
In-Reply-To: <CAHQjnOOCQb4G1aeFB0FQVBstXpaXmahnQO8+FoinPcQNZEieGg@mail.gmail.com>
References: <017a01ccfdee$4e5e7a00$eb1b6e00$%cho@samsung.com>
 <20120312150156.GF18973@amd.com>
 <CAHQjnOOCQb4G1aeFB0FQVBstXpaXmahnQO8+FoinPcQNZEieGg@mail.gmail.com>
Message-ID: <20120313100024.GG18973@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 05:50:16PM +0900, KyongHo Cho wrote:
> >> +struct sysmmu_drvdata {
> >> + ? ? struct device *sysmmu;
> >> + ? ? char *dbgname;
> >> + ? ? int nsfrs;
> >> + ? ? void __iomem **sfrbases;
> >> + ? ? struct clk *clk[2];
> >> + ? ? int activations;
> >> + ? ? rwlock_t lock;
> >> + ? ? struct iommu_domain *domain;
> >> + ? ? sysmmu_fault_handler_t fault_handler;
> >> + ? ? unsigned long pgtable;
> >> + ? ? struct iommu_client client;
> >> +};
> >
> > Is there any reason why 'struct iommu_client' is a seperate data
> > structure? Otherwise it can be merged with 'truct sysmmu_drvdata'.

Of course this doesn't need to be changed immediatly. I just asked if
there was a specific reason for this seperation.

> The problems will be soon fixed and I will post next patch tomorrow.

Fine. Please also get the Acked-bys from the Exynos maintainer on
patches 1 and 2 at least. I'll merge it then.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
