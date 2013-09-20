From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 20 Sep 2013 12:44:00 +0530
Subject: [PATCH 1/3] PM / OPP: rename functions to dev_pm_opp*
In-Reply-To: <1379624632-17356-2-git-send-email-nm@ti.com>
References: <1379624632-17356-1-git-send-email-nm@ti.com>
 <1379624632-17356-2-git-send-email-nm@ti.com>
Message-ID: <CAKohpoku7n6b2dDKD=+3DqG4pHtmWoeXZnAt3EoFRp+rNFofYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 September 2013 02:33, Nishanth Menon <nm@ti.com> wrote:
> opp_get_opp_count
> opp_find_freq_exact
> opp_init_cpufreq_table
> opp_free_cpufreq_table

The only problem I see is that routines names for few of them are getting
really long now.. Otherwise not much I could find...

Though you had following changes, which you could have avoided in this
hard to review patchset:

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
        new_opp = [-kzalloc(sizeof(struct
opp),-]{+kzalloc(sizeof(*new_opp),+} GFP_KERNEL);
        new_opp = [-kmalloc(sizeof(struct
opp),-]{+kmalloc(sizeof(*new_opp),+} GFP_KERNEL);

It is almost impossible to catch these with naked eyes for such long
patches.. I took help of --word-diff though :)

If no one else sees these as problems then feel free to add my:
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
