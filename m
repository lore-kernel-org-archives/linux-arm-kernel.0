From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 3 Mar 2015 22:03:31 +0800
Subject: [PATCH 1/2] cpufreq-dt: support cluster level clock
In-Reply-To: <CAKohpoksXwMRWYzSBmbV1nN5_LvUiB1Y2wfgOcCJPx+oipaXZw@mail.gmail.com>
References: <1425387817-11382-1-git-send-email-leo.yan@linaro.org>
 <1425387817-11382-2-git-send-email-leo.yan@linaro.org>
 <CAKohpoksXwMRWYzSBmbV1nN5_LvUiB1Y2wfgOcCJPx+oipaXZw@mail.gmail.com>
Message-ID: <20150303140331.GA11325@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 06:40:23PM +0530, Viresh Kumar wrote:
> On 3 March 2015 at 18:33, Leo Yan <leo.yan@linaro.org> wrote:
> > In the previous code, cpufreq-dt driver support single clock shared by
> > all CPUs or every CPU has dedicated clock; but it cannot support cluster
> > level clock domain, which is very common implementation for ARM SoCs.
> >
> > So this patch add the support for cluster level clock; which use the
> > platform parameter "clk_domain_boundary" to indicate whether the clock
> > domain is bound to system level, cluster level or CPU level.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> No. We aren't going to do it this way. You just test your current SoC where
> all CPUs share clock line. The other SoC that might come later, where
> clocks are per cluster, can be handled later.
> 
> So, for now you don't need any changes in the driver I believe.

Correct, current SoC shares one clock line.

I'm just thinking to finish things in one time. From my previous
experience, clocks per cluster are common cases for ARM's
multi-clusters, so i think it's reasonable to add related support.

Regarding of testing this patch, i created two virtual clocks for
every cluster and passed the test. Do u think this is acceptable?

Thanks,
Leo Yan
