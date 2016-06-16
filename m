From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 15 Jun 2016 17:57:40 -0700
Subject: [PATCH 3/5] ARM: dts: add L2CC and RPM with regulators for MSM8660
In-Reply-To: <CACRpkdZFGUKWiA21j2z4jxMOC=zg8oqC93YjkZR57xumxyJRQQ@mail.gmail.com>
References: <1465918259-11138-1-git-send-email-linus.walleij@linaro.org>
 <1465918259-11138-4-git-send-email-linus.walleij@linaro.org>
 <20160614185517.GG28218@codeaurora.org>
 <CACRpkdZFGUKWiA21j2z4jxMOC=zg8oqC93YjkZR57xumxyJRQQ@mail.gmail.com>
Message-ID: <5761F984.2060305@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2016 06:16 AM, Linus Walleij wrote:
> On Tue, Jun 14, 2016 at 8:55 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>
>>
>> Just leave these out? RPM shouldn't be touching s0 or s1.
> Really? The msm-3.4 tree does:
>
>         /* RPM early regulator constraints */
>         static struct rpm_regulator_init_data
> rpm_regulator_early_init_data[] = {
>         /*       ID       a_on pd ss min_uV   max_uV   init_ip    freq */
>         RPM_SMPS(PM8058_S0, 0, 1, 1,  500000, 1325000, SMPS_HMIN, 1p60),
>         RPM_SMPS(PM8058_S1, 0, 1, 1,  500000, 1250000, SMPS_HMIN, 1p60),
>
> Are you sure you don't mean s0+s1 on PM8901 (which I left out)?
>

Ah yes, I meant pm8901.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
