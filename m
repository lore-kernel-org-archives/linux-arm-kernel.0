From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Tue, 1 Dec 2015 23:09:49 +0800
Subject: [PATCH v6] clk: mediatek: Export CPU mux clocks for CPU frequency
 control
In-Reply-To: <CAGS+omCkYTPyjMk6QaoxGAL4QVU8VcpWyFqWhST+iP2EFRcRYg@mail.gmail.com>
References: <1442230072-31593-1-git-send-email-pi-cheng.chen@linaro.org>
 <CAGS+omCkYTPyjMk6QaoxGAL4QVU8VcpWyFqWhST+iP2EFRcRYg@mail.gmail.com>
Message-ID: <CALx668XVnhhLJWs7RBxvaX=SU=S9=wFVT9HMDP2edqiH4Jio4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 11:48 AM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> Hi Pi-Cheng and Michael,
>
> On Mon, Sep 14, 2015 at 7:27 PM, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
>> From: "pi-cheng.chen" <pi-cheng.chen@linaro.org>
>>
>> This patch adds CPU mux clocks which are used by Mediatek cpufreq driver
>> for intermediate clock source switching.
>
> It looks like this patch was never picked up.
> It is required for MT8173 cpufreq.
>
> What is the plan to get this one merged?

Hi Dan,
Mike is working on a new CCF feature called "coordinated clock rate changes"
which would help to migrate mt8173-cpufreq driver to generic cpufreq-dt
driver, and I am working with him to port MT8173 clock driver on the new
feature. So I think that's why this patch was not picked since it will
be migrated to new implementation once the new feature's ready.

@Mike:
Are you plannig to post those patches on the mailing list ?
Or is it fine for you to take this first and then I will refine it for
the new feature later?

Best Regards,
Pi-Cheng

>
> -Dan
>
>>
>> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
>> ---
>> Changes in v6:
>> - Relace __clk_get_num_parents with clk_hw_get_num_parents to reflect
>>   API change
>>
>> Changes in v5:
>> - Replace __initdata with __initconst to fix compiling error
>>
>> Changes in v4:
>> - Fix some minor issues for v3
>> - Rebase to the patch that adds 13mhz clock for MT8173[1]
>>
>> Changes in v3:
>> - Rebase to 4.2-rc1
>> - Fix some issues of v2
>>
>> Changes in v2:
>> - Remove use of .determine_rate callback
>> ---
>>  drivers/clk/mediatek/Makefile          |   2 +-
>>  drivers/clk/mediatek/clk-cpumux.c      | 127 +++++++++++++++++++++++++++++++++
>>  drivers/clk/mediatek/clk-cpumux.h      |  22 ++++++
>>  drivers/clk/mediatek/clk-mt8173.c      |  23 ++++++
>>  include/dt-bindings/clock/mt8173-clk.h |   4 +-
>>  5 files changed, 176 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/clk/mediatek/clk-cpumux.c
>>  create mode 100644 drivers/clk/mediatek/clk-cpumux.h
>
> [snip]
