From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 12 Jun 2018 16:58:57 +0200
Subject: [PATCH v3 0/5] PM / Domains: Add support for multi PM domains per
 device
In-Reply-To: <20180531105959.14843-1-ulf.hansson@linaro.org>
References: <20180531105959.14843-1-ulf.hansson@linaro.org>
Message-ID: <3721375.shleKqokg2@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, May 31, 2018 12:59:54 PM CEST Ulf Hansson wrote:
> Changes in v3:
> 	- Drop patch 1->4 as they have already been applied.
> 	- Collected tags, for tests and reviews.
> 	- Minor update to function descriptions in patch 4 (earlier 8) and 5
> 	(earlier9).
> 	- Note, because of the minor changes, no history is provided per patch.
> 
> Changes in v2:
> 	- Addressed comments from Geert around DT doc.
> 	- Addressed comments from Jon around clarification of how to use this
> 	and changes to returned error codes.
> 	- Fixed build error in case CONFIG_PM was unset.
> 
> There are devices that are partitioned across multiple PM domains. Currently
> these can't be supported well by the available PM infrastructures we have in
> the kernel. This series is an attempt to address this.
> 
> One existing case where devices are partitioned across multiple PM domains, is
> the Nvida Tegra 124/210 X-USB subsystem. A while ago Jon Hunter (Nvidia) sent a
> series, trying to address these issues, however this is a new approach, while
> it re-uses the same concepts from DT point of view.
> 
> The Tegra 124/210 X-USB subsystem contains of a host controller and a device
> controller. Each controller have its own independent PM domain, but are being
> partitioned across another shared PM domain for the USB super-speed logic.
> 
> Currently to make the drivers work, either the related PM domains needs to stay
> powered on always or the PM domain topology needs to be in-correctly modelled
> through sub-domains. In both cases PM domains may be powered on while they
> don't need to be, so in the end this means - wasting power -.
> 
> As stated above, this series intends to address these problem from a PM
> infrastructure point of view. More details are available in each changelog.
> 
> Kind regards
> Ulf Hansson
> 
> Ulf Hansson (5):
>   PM / Domains: dt: Allow power-domain property to be a list of
>     specifiers
>   PM / Domains: Don't attach devices in genpd with multi PM domains
>   PM / Domains: Split genpd_dev_pm_attach()
>   PM / Domains: Add support for multi PM domains per device to genpd
>   PM / Domains: Add dev_pm_domain_attach_by_id() to manage multi PM
>     domains
> 
>  .../bindings/power/power_domain.txt           |  19 ++-
>  drivers/base/power/common.c                   |  43 +++++-
>  drivers/base/power/domain.c                   | 134 +++++++++++++++---
>  include/linux/pm_domain.h                     |  15 ++
>  4 files changed, 183 insertions(+), 28 deletions(-)
> 
> 

Applied, thanks!
