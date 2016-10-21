From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 21 Oct 2016 11:35:01 -0700
Subject: [PATCH v3 0/8] PM / Domains: DT support for domain idle states &
 atomic PM domains
In-Reply-To: <CAPDyKFpQwOkXUk8wT6sZ-Ad4XpTnyodK5m24fYJ3P+1QtS0XOA@mail.gmail.com>
 (Ulf Hansson's message of "Mon, 17 Oct 2016 09:30:53 +0200")
References: <1476467276-75094-1-git-send-email-lina.iyer@linaro.org>
 <CAPDyKFpQwOkXUk8wT6sZ-Ad4XpTnyodK5m24fYJ3P+1QtS0XOA@mail.gmail.com>
Message-ID: <7hmvhxpn3e.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 14 October 2016 at 19:47, Lina Iyer <lina.iyer@linaro.org> wrote:
>> Hi all,
>>
>> Changes since v2 [3] -
>> - Addressed review comments from v2.
>>         - domain-idle-states documentation updated
>>         - fixed compiler issues with imx driver
>>         - minor code change in pm_domains.c
>> - The series is available at [4].
>>
>> Changes since v1 [2] -
>> - Addressed review comments from v1.
>>         - Fixes around dynamic allocation of genpd states
>>         - Used OF method for iterating phandles
>>         - Updated documentation, examples
>>         - Rename state variable (provider -> fwnode)
>> - The series is available at [3].
>>
>> The changes from [1] are -
>> - Allocating memory for domain idle states dynamically
>> - Conform to naming conventions for internal and exported genpd functions
>> - DT binding example for domain-idle-state
>> - Use fwnode instead of of_node
>> - Handle atomic case for removal of PM Domain
>> - Rebase on top of Rafael's pm/genpd tree
>>
>> Thanks,
>> Lina
>>
>> Lina Iyer (8):
>>   PM / Domains: Make genpd state allocation dynamic
>>   PM / Domain: Add residency property to genpd states
>>   PM / Domains: Allow domain power states to be read from DT
>>   PM / Domains: Save the fwnode in genpd_power_state
>>   dt/bindings: Update binding for PM domain idle states
>>   PM / Domains: Abstract genpd locking
>>   PM / Domains: Support IRQ safe PM domains
>>   PM / doc: Update device documentation for devices in IRQ safe PM
>>     domains
>>
>>  .../devicetree/bindings/power/power_domain.txt     |  43 +++
>>  Documentation/power/devices.txt                    |   9 +-
>>  arch/arm/mach-imx/gpc.c                            |  17 +-
>>  drivers/base/power/domain.c                        | 358 +++++++++++++++++----
>>  include/linux/pm_domain.h                          |  28 +-
>>  5 files changed, 383 insertions(+), 72 deletions(-)
>>
>
> Rafael, Lina,
>
> This looks good to me! Unless any other objections, I suggest to apply
> this to get it tested in linux-next.

Looks like it might be a little late now, but anyways

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
