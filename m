From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 15 Jun 2016 16:46:38 +0200
Subject: [RFC PATCH 0/8] PM / Domains: Add support for removing PM domains
In-Reply-To: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
References: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <CAPDyKFoUxknMzF-TReS+3LkRLvw-X1SeBCw83_y_bsXVGJVnXA@mail.gmail.com>
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

Apologize for the long delay!

I have looked through this now and I really like this!

There were a few comments, but those should be easily taken care of.
So please go ahead and re-spin a new version!

There are a few outstanding genpd patches which I have posted a while
ago but which isn't yet queued for 4.8.
I don't know whether those will conflict with this series (if they get
merged prior to this), but I guess it's better if you anyway base you
series on Rafael's latest changes instead of on top of mine...

Kind regards
Uffe
