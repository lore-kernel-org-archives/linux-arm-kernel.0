From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Mon, 2 Jul 2018 11:50:27 +0530
Subject: [PATCH 0/3] PM / Domains: Enable name based lookup at attach
In-Reply-To: <20180629110432.5179-1-ulf.hansson@linaro.org>
References: <20180629110432.5179-1-ulf.hansson@linaro.org>
Message-ID: <339eb0d1-7b85-4cc1-55b6-8d3f68f73182@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/29/2018 04:34 PM, Ulf Hansson wrote:
> Recently we added support to manage multiple PM domains per device. Consumer
> drivers were provided an API, dev_pm_domain_attach_by_id() to associate its
> device with one of its PM domain, by using an index.
> 
> Let's extend this to allow the association to be done using a name based
> lookup, which follows the similar concept as for other resource types, such as
> clocks for example.

Updated [1] to use dev_pm_domain_attach_by_name() instead of dev_pm_domain_attach_by_id()
Everything works as expected.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>

[1] https://patchwork.kernel.org/patch/10496107/
 
> 
> Ulf Hansson (3):
>   PM / Domains: dt: Add a power-domain-names property
>   PM / Domains: Introduce option to attach a device by name to genpd
>   PM / Domains: Introduce dev_pm_domain_attach_by_name()
> 
>  .../bindings/power/power_domain.txt           |  8 +++++++
>  drivers/base/power/common.c                   | 17 +++++++++++++
>  drivers/base/power/domain.c                   | 24 +++++++++++++++++++
>  include/linux/pm_domain.h                     | 15 ++++++++++++
>  4 files changed, 64 insertions(+)
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
