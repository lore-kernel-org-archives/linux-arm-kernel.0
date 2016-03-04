From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 4 Mar 2016 13:33:30 +0100
Subject: [RFC PATCH 0/8] PM / Domains: Add support for removing PM domains
In-Reply-To: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
References: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <CAPDyKFq3hNARzjSOoP+-NmcgfSWzG6GDmh7qVX6yx6QPgN9Arw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2016 at 12:23, Jon Hunter <jonathanh@nvidia.com> wrote:
> In order to safely remove PM domains there are a few changes that need to be
> made to ensure that no one is holding an external reference to a PM domain
> after it has been removed. One solution, implemented here, solves this by
> eliminating external references to PM domain. Another alternative would be
> to employ some reference counting for the PM domains, however, I did not see
> a good reason for allowing external references in the first place (as always
> there could be something that I have over-looked!).
>
> Jon Hunter (8):
>   PM / Domains: Add new helper functions for device-tree
>   ARM: EXYNOS: Remove calls to of_genpd_get_from_provider()
>   staging: board: Remove calls to of_genpd_get_from_provider()
>   PM / Domains: Don't expose generic_pm_domain structure
>   PM / Domains: Verify the PM domain is present when adding a provider
>   PM / Domains: Remove a provider by referencing the data pointer
>   PM / Domains: Prepare for adding support to remove PM domains
>   PM / Domains: Add support for removing PM domains
>
>  arch/arm/mach-exynos/pm_domains.c |  23 +--
>  drivers/base/power/domain.c       | 324 +++++++++++++++++++++++++++++++++++---
>  drivers/staging/board/board.c     |   9 +-
>  include/linux/pm_domain.h         |  55 ++++---
>  4 files changed, 348 insertions(+), 63 deletions(-)
>
> --
> 2.1.4
>

Jon, thanks for posting this!
My initial impressions is the I like the ideas for where you moves this.

I will review it in more details as soon as I can (travelling next week).

Kind regards
Uffe
