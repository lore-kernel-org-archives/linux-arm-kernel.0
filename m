From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 7 Aug 2015 10:48:26 +0530
Subject: [PATCH v4 0/6] cpufreq: use generic cpufreq drivers for
 Exynos4x12 platform
In-Reply-To: <55C43971.5010504@samsung.com>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
 <015301d0d0a3$1396c900$3ac45b00$@kernel.org>
 <20150807035018.GF6325@linux> <20150807035156.GG6325@linux>
 <55C43085.8090506@samsung.com> <20150807043037.GH6325@linux>
 <55C43971.5010504@samsung.com>
Message-ID: <20150807051826.GJ6325@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-08-15, 13:52, Krzysztof Kozlowski wrote:
> Thanks for explanation. As fair as I understand, Bartlomiej wanted to
> merge this in a way which would avoid loosing the boost mode. Kukjin
> prepared topic branches for previous cpu-freq/clk stuff so maybe
> everything could go through PM?

We aren't loosing anything at all. There can be two cases here:

1. Patch 1/6 and 6/6 make it to 4.3 (with suggested changes) via PM tree:
- All will work fine in this case, no issues at all..

2. They don't make it:
- Even in this case, nothing will break. Users can just enable a
  config option and that's all..

So, no need to divert things into another tree this late.

Over that, Rafael will not be around for 2 weeks now (Plumbers and
other stuff) ..

So, just target the cpufreq core changes via PM tree.. rest is just
fine.

I hope that makes sense :)

-- 
viresh
