From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 3 Aug 2018 13:44:08 +0200
Subject: [PATCH v8 05/26] PM / Domains: Add helper functions to
 attach/detach CPUs to/from genpd
In-Reply-To: <3889041.sTGkQNs1Ck@aspire.rjw.lan>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <20180620172226.15012-6-ulf.hansson@linaro.org>
 <3889041.sTGkQNs1Ck@aspire.rjw.lan>
Message-ID: <CAPDyKFrteziAy==C+-mEiV-404--qwBu8JLoSAHYJjb8p1a+Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 July 2018 at 12:22, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, June 20, 2018 7:22:05 PM CEST Ulf Hansson wrote:
>> Introduce two new genpd helper functions, of_genpd_attach|detach_cpu(),
>> which takes the CPU-number as an in-parameter.
>>
>> To attach a CPU to a genpd, of_genpd_attach_cpu() starts by fetching the
>> struct device belonging to the CPU. Then it calls genpd_dev_pm_attach(),
>> which via DT tries to hook up the CPU device to its corresponding PM
>> domain. If it succeeds, of_genpd_attach_cpu() continues to prepare/enable
>> runtime PM of the device.
>>
>> To detach a CPU from its PM domain, of_genpd_attach_cpu() reverse the
>> operations made from of_genpd_attach_cpu(). However, first it checks that
>> the CPU device has a valid PM domain pointer assigned, as to make sure it
>> belongs to genpd.
>>
>> Cc: Lina Iyer <ilina@codeaurora.org>
>> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/base/power/domain.c | 69 +++++++++++++++++++++++++++++++++++++
>>  include/linux/pm_domain.h   |  9 +++++
>>  2 files changed, 78 insertions(+)

[...]

> I'd combine this with patch [04/26].  The split here is somewhat artificial IMO.

I wanted to keep one change per patch, hence the split.

$subject patch introduces helpers to add CPU devices to genpd and
isn't really part of making genpd to cope with CPU devices. So
$subject patch is about avoiding open coding.

Are you still sure you want me to squash the changes?

Kind regards
Uffe
