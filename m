From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 07 Aug 2015 13:47:26 +0200
Subject: [PATCH v4 0/6] cpufreq: use generic cpufreq drivers for Exynos4x12
 platform
In-Reply-To: <20150807113950.GG6939@linux>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
 <2061119.GBaoSb4YSL@amdc1976> <20150807113950.GG6939@linux>
Message-ID: <2359635.Hxe4cb8zKm@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, August 07, 2015 05:09:50 PM Viresh Kumar wrote:
> On 07-08-15, 13:31, Bartlomiej Zolnierkiewicz wrote:
> > Users don't need to enable the config option to get boost
> > functionality working.  It is only needed to get scaling_boost_freqs
> > sysfs attribute visible (which lists available boost freqs) when
> > using cpufreq-dt driver.  Also the config option in question is not
> > user visible.
> 
> By users I meant the people who will prepare the build images for the
> release. They can just enable the config option :)

OK.

> > The worst thing that happens if these 2 PM patches don't make it
> > in time is that there will be no scaling_boost_freqs available
> > when using cpufreq-dt driver.  Which is not very important from
> > Exynos4x12 POV as it only supports single boost freq currently.
> 
> Right. So, now that your patch is Acked, send 1/6 and 6/6 separately
> to pm-list and Rafael can get them merged himself..
> 
> I hope, your 6/6 patch will change a bit now ?

Hmm, wait.  Patch 6/6 depends on earlier changes.  I cannot remove
the config option in question now as it is currently used by
exynos-cpufreq specific boost support.  Patch 1/6 can be applied
now but 6/6 needs to wait for patches 2-5 to be applied first.

Actually 6/6 is trivial and can be applied later in v4.3 cycle or
even in v4.4 one.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
