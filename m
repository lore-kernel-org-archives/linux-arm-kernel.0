From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 22 Nov 2011 10:01:30 -0800
Subject: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
In-Reply-To: <CACxGe6sOd6MiyYaok6BsihJtp-NNsm3WQf+aUPGMRFRpSLw2mQ@mail.gmail.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-6-git-send-email-mturquette@linaro.org>
 <CACxGe6sOd6MiyYaok6BsihJtp-NNsm3WQf+aUPGMRFRpSLw2mQ@mail.gmail.com>
Message-ID: <CAPtuhTheG-mvoGMaB2y9BSKF-abm2yigoN-SXaeCb+P5R6t_Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 8:37 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>
> On Nov 21, 2011 6:43 PM, "Mike Turquette" <mturquette@ti.com> wrote:
>>
>> Introduces kobject support for the common struct clk, exports per-clk
>> data via read-only callbacks and models the clk tree topology in sysfs.
>>
>> Also adds support for generating the clk tree in clk_init and migrating
>> nodes when input sources are switches in clk_set_parent.
>
> I'm not convinced this is a good idea. What is the use case for exporting
> the clock tree? If it is debug, then I suggest using debugfs to avoid abi
> issues.

Each clk exports clk_rate, clk_flags, clk_enable_count &
clk_prepare_count as Read-Only.  I think this is very reasonable to
have in sysfs, which maps the topology of the system with key details.

Others have requested to have knobs made available for actually
performing clk_enable/clk_disable and even clk_set_rate from
userspace.  I hate this idea and won't implement it.  I encourage
anyone that needs this to do it in debugfs.

Does that work-split make sense to you, or do you still not like the
idea of having topology and read-only info in sysfs?

Regards,
Mike

>
> g.
