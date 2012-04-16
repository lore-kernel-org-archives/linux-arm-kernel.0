From: subashrp@gmail.com (Subash Patel)
Date: Mon, 16 Apr 2012 19:05:57 +0530
Subject: [PATCH 0/2] Exynos: fix SYSMMU driver to work with power domains
In-Reply-To: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com>
References: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <4F8C203D.3000407@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marek,

I have tested these patches on origen 3.4-rc2 with sysmmu_v12, and they 
work great ! Thank you for sharing them.

Regards,
Subash

On 04/11/2012 08:04 PM, Marek Szyprowski wrote:
> Hi!
>
> These two patches fixes operation of the SYSMMU driver (v12 version [1])
> with the new power domain driver based on generic power domains and
> runtime pw, which has been merged to Linux kernel v3.4-rc1.
>
> [1] https://lkml.org/lkml/2012/3/15/51
>
> Best regards
> Marek Szyprowski
> Samsung Poland R&D Center
>
>
> Patch summary:
>
> Marek Szyprowski (2):
>    iommu/exynos: fix runtime pm support
>    ARM: Exynos4: update SYSMMU setup code for gen_pd power domain driver
>
>   arch/arm/mach-exynos/dev-sysmmu.c |    6 +++++-
>   arch/arm/mach-exynos/pm_domains.c |   13 +++++++++++++
>   drivers/iommu/exynos-iommu.c      |   20 ++++++++++++++++++--
>   3 files changed, 36 insertions(+), 3 deletions(-)
>
