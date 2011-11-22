From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 22 Nov 2011 12:19:51 -0700
Subject: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
In-Reply-To: <CAPtuhTheG-mvoGMaB2y9BSKF-abm2yigoN-SXaeCb+P5R6t_Dg@mail.gmail.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-6-git-send-email-mturquette@linaro.org>
 <CACxGe6sOd6MiyYaok6BsihJtp-NNsm3WQf+aUPGMRFRpSLw2mQ@mail.gmail.com>
 <CAPtuhTheG-mvoGMaB2y9BSKF-abm2yigoN-SXaeCb+P5R6t_Dg@mail.gmail.com>
Message-ID: <CACxGe6vK-vHvSbd9N2k3FZY4gGVS_DETx0BbfPgNghTkOncjpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 11:01 AM, Mike Turquette <mturquette@linaro.org> wrote:
> On Tue, Nov 22, 2011 at 8:37 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>
>> On Nov 21, 2011 6:43 PM, "Mike Turquette" <mturquette@ti.com> wrote:
>>>
>>> Introduces kobject support for the common struct clk, exports per-clk
>>> data via read-only callbacks and models the clk tree topology in sysfs.
>>>
>>> Also adds support for generating the clk tree in clk_init and migrating
>>> nodes when input sources are switches in clk_set_parent.
>>
>> I'm not convinced this is a good idea. What is the use case for exporting
>> the clock tree? If it is debug, then I suggest using debugfs to avoid abi
>> issues.
>
> Each clk exports clk_rate, clk_flags, clk_enable_count &
> clk_prepare_count as Read-Only. ?I think this is very reasonable to
> have in sysfs, which maps the topology of the system with key details.
>
> Others have requested to have knobs made available for actually
> performing clk_enable/clk_disable and even clk_set_rate from
> userspace. ?I hate this idea and won't implement it. ?I encourage
> anyone that needs this to do it in debugfs.
>
> Does that work-split make sense to you, or do you still not like the
> idea of having topology and read-only info in sysfs?

Unless there is a solid real-world use case for exporting this data to
userspace, I do not think sysfs is a good idea.  As long as the usage
(beyond debug) is theoretical I think the whole thing should be in
debugfs.  It can always be moved at a later date If a real use case
does become important.

g.
