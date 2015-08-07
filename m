From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 07 Aug 2015 13:31:15 +0200
Subject: [PATCH v4 0/6] cpufreq: use generic cpufreq drivers for Exynos4x12
 platform
In-Reply-To: <20150807051826.GJ6325@linux>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
 <55C43971.5010504@samsung.com> <20150807051826.GJ6325@linux>
Message-ID: <2061119.GBaoSb4YSL@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Friday, August 07, 2015 10:48:26 AM Viresh Kumar wrote:
> On 07-08-15, 13:52, Krzysztof Kozlowski wrote:
> > Thanks for explanation. As fair as I understand, Bartlomiej wanted to
> > merge this in a way which would avoid loosing the boost mode. Kukjin
> > prepared topic branches for previous cpu-freq/clk stuff so maybe
> > everything could go through PM?
> 
> We aren't loosing anything at all. There can be two cases here:
> 
> 1. Patch 1/6 and 6/6 make it to 4.3 (with suggested changes) via PM tree:
> - All will work fine in this case, no issues at all..
> 
> 2. They don't make it:
> - Even in this case, nothing will break. Users can just enable a
>   config option and that's all..

Users don't need to enable the config option to get boost
functionality working.  It is only needed to get scaling_boost_freqs
sysfs attribute visible (which lists available boost freqs) when
using cpufreq-dt driver.  Also the config option in question is not
user visible.

The worst thing that happens if these 2 PM patches don't make it
in time is that there will be no scaling_boost_freqs available
when using cpufreq-dt driver.  Which is not very important from
Exynos4x12 POV as it only supports single boost freq currently.

> So, no need to divert things into another tree this late.

I agree.

> Over that, Rafael will not be around for 2 weeks now (Plumbers and
> other stuff) ..
> 
> So, just target the cpufreq core changes via PM tree.. rest is just
> fine.
> 
> I hope that makes sense :)

Yes. :)
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
