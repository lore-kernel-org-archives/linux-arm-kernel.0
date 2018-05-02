From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 2 May 2018 14:31:33 +0200
Subject: [PATCH 00/11] PM / Domains: Fixup error paths with
 dev_pm_domain_attach()
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAPDyKFrUmNyMQ9Aqgwg-Ncf08fYgAqaY_MckvxqsrUq7mr-LQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 April 2018 at 10:52, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> While I was on working adding support for multiple PM domains to genpd, I
> stumbled over several problems in the error path related to
> dev_pm_domain_attach(). Hence, I decided to fix these problems first, which is
> what this series intends to address.
>
> There first patch is material for stable, as it fixes a real bug in genpd,
> while the rest may be considered as improvement of the error paths when devices
> fails to be attached to their PM domains.
>
> I am seeking acks from subsystem maintainers and suggest with funnel the hole
> series through Rafael's linux-pm tree, unless there are objections to that of
> course.
>
> Ulf Hansson (11):
>   PM / Domains: Fix error path during attach in genpd
>   PM / Domains: Drop comment in genpd about legacy Samsung DT binding
>   PM / Domains: Drop redundant code in genpd while attaching devices
>   PM / Domains: Check for existing PM domain in dev_pm_domain_attach()
>   PM / Domains: Allow a better error handling of dev_pm_domain_attach()
>   amba: Respect all error codes from dev_pm_domain_attach()
>   driver core: Respect all error codes from dev_pm_domain_attach()
>   i2c: Respect all error codes from dev_pm_domain_attach()
>   mmc: sdio: Respect all error codes from dev_pm_domain_attach()
>   soundwire: Respect all error codes from dev_pm_domain_attach()
>   spi: Respect all error codes from dev_pm_domain_attach()
>
>  drivers/acpi/device_pm.c     |  9 +++------
>  drivers/amba/bus.c           |  4 ++--
>  drivers/base/platform.c      | 17 ++++++++---------
>  drivers/base/power/common.c  | 10 +++++++---
>  drivers/base/power/domain.c  | 45 +++++++++++++++-----------------------------
>  drivers/i2c/i2c-core-base.c  |  2 +-
>  drivers/mmc/core/sdio_bus.c  |  2 +-
>  drivers/soundwire/bus_type.c | 15 +++++++--------
>  drivers/spi/spi.c            | 11 ++++++-----
>  include/linux/acpi.h         |  2 +-
>  include/linux/pm_domain.h    |  2 +-
>  11 files changed, 52 insertions(+), 67 deletions(-)

Rafael,

I understand if you are busy so this is not a ping. :-)

However, perhaps I can simplify by sending you a PR with these!?

Kind regards
Uffe
