From: nm@ti.com (Nishanth Menon)
Date: Fri, 20 Sep 2013 07:38:08 -0500
Subject: [PATCH 1/3] PM / OPP: rename functions to dev_pm_opp*
In-Reply-To: <CAKohpoku7n6b2dDKD=+3DqG4pHtmWoeXZnAt3EoFRp+rNFofYA@mail.gmail.com>
References: <1379624632-17356-1-git-send-email-nm@ti.com>
 <1379624632-17356-2-git-send-email-nm@ti.com>
 <CAKohpoku7n6b2dDKD=+3DqG4pHtmWoeXZnAt3EoFRp+rNFofYA@mail.gmail.com>
Message-ID: <20130920123808.GA22176@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:44-20130920, Viresh Kumar wrote:
> On 20 September 2013 02:33, Nishanth Menon <nm@ti.com> wrote:
> > opp_get_opp_count
> > opp_find_freq_exact
> > opp_init_cpufreq_table
> > opp_free_cpufreq_table
> 
> The only problem I see is that routines names for few of them are getting
> really long now.. Otherwise not much I could find...
I am open to suggestions if any one feels we can improve this better.

> 
> Though you had following changes, which you could have avoided in this
> hard to review patchset:
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
>         new_opp = [-kzalloc(sizeof(struct
> opp),-]{+kzalloc(sizeof(*new_opp),+} GFP_KERNEL);
>         new_opp = [-kmalloc(sizeof(struct
> opp),-]{+kmalloc(sizeof(*new_opp),+} GFP_KERNEL);
> 
> It is almost impossible to catch these with naked eyes for such long
> patches.. I took help of --word-diff though :)
I believe that change was from Patch #2[1]
yes, you are right, I had squashed this patch in to squelch checkpatch
warnings:
CHECK: Prefer kzalloc(sizeof(*new_opp)...) over kzalloc(sizeof(struct
		       dev_pm_opp)...)
#177: FILE: drivers/base/power/opp.c:406:
+	new_opp = kzalloc(sizeof(struct dev_pm_opp), GFP_KERNEL);

CHECK: Prefer kmalloc(sizeof(*new_opp)...) over kmalloc(sizeof(struct
		       dev_pm_opp)...)
#191: FILE: drivers/base/power/opp.c:495:
+	new_opp = kmalloc(sizeof(struct dev_pm_opp), GFP_KERNEL);


I had added a comment:
" Minor checkpatch warning fixes as a result of this change was fixed as
well."

Would you suggest I split the change off to a separate patch or improve
 the comment a little more?
> 
> If no one else sees these as problems then feel free to add my:
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

[1] https://patchwork.kernel.org/patch/2913551/
-- 
Regards,
Nishanth Menon
