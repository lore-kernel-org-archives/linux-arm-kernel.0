From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 3 Mar 2015 18:40:23 +0530
Subject: [PATCH 1/2] cpufreq-dt: support cluster level clock
In-Reply-To: <1425387817-11382-2-git-send-email-leo.yan@linaro.org>
References: <1425387817-11382-1-git-send-email-leo.yan@linaro.org>
 <1425387817-11382-2-git-send-email-leo.yan@linaro.org>
Message-ID: <CAKohpoksXwMRWYzSBmbV1nN5_LvUiB1Y2wfgOcCJPx+oipaXZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 March 2015 at 18:33, Leo Yan <leo.yan@linaro.org> wrote:
> In the previous code, cpufreq-dt driver support single clock shared by
> all CPUs or every CPU has dedicated clock; but it cannot support cluster
> level clock domain, which is very common implementation for ARM SoCs.
>
> So this patch add the support for cluster level clock; which use the
> platform parameter "clk_domain_boundary" to indicate whether the clock
> domain is bound to system level, cluster level or CPU level.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

No. We aren't going to do it this way. You just test your current SoC where
all CPUs share clock line. The other SoC that might come later, where
clocks are per cluster, can be handled later.

So, for now you don't need any changes in the driver I believe.

Please let me know if my understanding is wrong somewhere.

--
viresh
