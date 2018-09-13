From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 13 Sep 2018 13:18:34 +0530
Subject: [PATCH 00/11] OPP: Don't create multiple OPP tables for devices
 sharing OPP table
In-Reply-To: <20180912135537.GA9985@centauri.ideon.se>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
 <20180912135537.GA9985@centauri.ideon.se>
Message-ID: <CAKohpomVR_U9cA2yFLWjQ0pLdjp_d8=s2C7cvbauacha0Uv8xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 September 2018 at 19:25, Niklas Cassel <niklas.cassel@linaro.org> wrote:
> On Wed, Sep 12, 2018 at 01:58:39PM +0530, Viresh Kumar wrote:
>> Hello,
>>
>> Niklas Cassle recently reported some regressions with his Qcom cpufreq
>> driver where he was getting some errors while creating the OPPs tables.
>>
>> After looking into it I realized that the OPP core incorrectly creates
>> multiple OPP tables for the devices even if they are sharing the OPP
>> table in DT. This happens when the request comes using different CPU
>> devices. For example, dev_pm_opp_set_supported_hw() getting called using
>> CPU0 and dev_pm_opp_of_add_table() getting called using CPU1.
>>
>> This series redesigns the internals of the OPP core to fix that. The
>> redesign has simplified the core itself though.
>>
>> @Niklas: Can you please confirm that this series fixes the issues you
>> have reported ? I have already tested it on Hikey960.
>
> Hello Viresh,
>
> This fixes the OPP error messages that I previously reported.
>
> However, I also tested to add a duplicate OPP to the opp-table.
>
> Before this series, I got the first two error prints.
> After this series, I get the first two error prints + the use after free splat.

This looks to be an old bug. Can you please try this branch:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/qcom-fix

?
