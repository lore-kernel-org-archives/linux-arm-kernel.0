From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 11 Dec 2017 14:03:28 +0530
Subject: [PATCH v4 12/12] cpufreq: dt: Reintroduce independent_clocks
 platform data
In-Reply-To: <1512726150-7204-13-git-send-email-sricharan@codeaurora.org>
References: <1512726150-7204-1-git-send-email-sricharan@codeaurora.org>
 <1512726150-7204-13-git-send-email-sricharan@codeaurora.org>
Message-ID: <20171211083328.GE25177@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08-12-17, 15:12, Sricharan R wrote:
> The Platform data was removed earlier by,
> 'commit eb96924acddc ("cpufreq: dt: Kill platform-data")'
> since there were no users at that time.
> Now this is required when the each of the cpu clocks
> can be scaled independently, which is the case
> for krait cores. So reintroduce it.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 7 ++++++-
>  drivers/cpufreq/cpufreq-dt.h | 6 ++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)

Nack. This information should come from the OPP layer (Hint:
dev_pm_opp_of_get_sharing_cpus()).

-- 
viresh
