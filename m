From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 25 Jun 2018 10:34:38 +0200
Subject: [PATCH v8 03/26] PM / Domains: Add generic data pointer to
 genpd_power_state struct
In-Reply-To: <CAJZ5v0i52JTFbvBBaDyNHCnTz3UMW00NiodFpzS5m614D++9uA@mail.gmail.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <20180620172226.15012-4-ulf.hansson@linaro.org>
 <CAJZ5v0i52JTFbvBBaDyNHCnTz3UMW00NiodFpzS5m614D++9uA@mail.gmail.com>
Message-ID: <CAPDyKFrB71OyLTFX9huc30R+SXtMWw5Kn4qM4bXi-DHFM+UYfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 June 2018 at 23:09, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Jun 20, 2018 at 7:22 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> From: Lina Iyer <lina.iyer@linaro.org>
>>
>> Let's add a data pointer to the genpd_power_state struct, to allow
>> platforms to store per state specific data.
>
> Can you please fold it into a patch actually using this pointer?

Yep, no problem.

Anyway, the change that uses the pointer is "[PATCH v8 21/26] drivers:
firmware: psci: Add support for PM domains using genpd".

Let's see if there is further comments, if not - perhaps you can
squash $subject patch into that change?

>
>> Cc: Lina Iyer <ilina@codeaurora.org>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  include/linux/pm_domain.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index 9206a4fef9ac..27fca748344a 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -44,6 +44,7 @@ struct genpd_power_state {
>>         s64 residency_ns;
>>         struct fwnode_handle *fwnode;
>>         ktime_t idle_time;
>> +       void *data;
>>  };
>>
>>  struct genpd_lock_ops;
>> --
>> 2.17.1
>>

Kind regards
Uffe
