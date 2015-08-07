From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 7 Aug 2015 09:20:18 +0530
Subject: [PATCH v4 0/6] cpufreq: use generic cpufreq drivers for
 Exynos4x12 platform
In-Reply-To: <015301d0d0a3$1396c900$3ac45b00$@kernel.org>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
 <015301d0d0a3$1396c900$3ac45b00$@kernel.org>
Message-ID: <20150807035018.GF6325@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc'ing Rafael again. Guys please don't miss him for any PM related
stuff or use get_maintainers ..

Cc'ing Arnd/Olof as well to discuss the merge stuff..

On 07-08-15, 08:53, Kukjin Kim wrote:
> > Depends on:
> > - next-20150806 branch of linux-next kernel tree
> > - "[PATCH V3 00/16] OPP: Add code to support operating-points-v2 bindings"
> >   (http://www.spinics.net/lists/arm-kernel/msg435408.html)
> > 
> BTW, hmm...how can we see this series in v4.3?...to be honest, I don't think it
> can be done in v4.3 because of dependencies with PM / OPP series

That is merged by Rafael Yesterday. That is manageable 

> and previous
> exynos CPU OPP series in each cross trees...maybe that's why you created based
> on linux-next...any idea?

So there is no build dependency with OPP patches I hope, as its all
about using the bindings defined by them. And so you don't need to
depend on that.

You might have to rebase on the ARM tree to manage your conflicts. In
this case you can rebase directly on ARM SoC branch which has your
patches (rebase directly over the last patch instead of the whole
branch) and make sure Olof knows about this and he doesn't update
(i.e. rebase) his branch, which he might not anyway.

The whole idea is to keep a single sha-id for a commit. So you can
rebase over the published material present in ARM-SoC ..

-- 
viresh
