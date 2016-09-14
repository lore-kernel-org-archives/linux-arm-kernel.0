From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 14 Sep 2016 02:58:34 +0200
Subject: [PATCH V2 00/10] PM / Domains: Add support for removing PM domains
In-Reply-To: <1473678074-15126-1-git-send-email-jonathanh@nvidia.com>
References: <1473678074-15126-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <14914984.irHbtjz3da@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 12, 2016 12:01:04 PM Jon Hunter wrote:
> In order to safely remove PM domains there are a few changes that need to be
> made to ensure that no one is holding an external reference to a PM domain
> after it has been removed. One solution, implemented here, solves this by
> eliminating external references to PM domain.
> 
> Changes from V1:
> - Added test when removing a PM domain to ensure the PM domain provider
>   has been removed.
> - Re-organised patches 8-10 so that patch #8 adds the code to verify if
>   the provider is present, patch #9 adds basic support for removing PM
>   domains and patch #10 adds support for removing PM domains by provider.
> 
> Changes from initial RFC:
> - Renamed functions made static per Ulf's feedback.
> - Added patch to clean-up provider/xlate APIs per Ulf's feedback
> - Re-worked and simplified the association between PM domains and PM
>   domain providers. Dropped the 'provider_data' variable from the
>   generic_pm_domain structure in favour of using the fwnode_handle.
> - Split patch for removing PM domains into multiple patches per Ulf's
>   feedback.
> 
> Jon Hunter (10):
>   PM / Domains: Add new helper functions for device-tree
>   ARM: EXYNOS: Remove calls to of_genpd_get_from_provider()
>   staging: board: Remove calls to of_genpd_get_from_provider()
>   PM / Domains: Don't expose generic_pm_domain structure to clients
>   PM / Domains: Don't expose xlate and provider helper functions
>   PM / Domains: Verify the PM domain is present when adding a provider
>   PM / Domains: Prepare for adding support to remove PM domains
>   PM / Domains: Store the provider in the PM domain structure
>   PM / Domains: Add support for removing PM domains
>   PM / Domains: Add support for removing nested PM domains by provider

All applied.

I'll expose a branch containing them after they've spent a couple of days in
linux-next.

Thanks,
Rafael
