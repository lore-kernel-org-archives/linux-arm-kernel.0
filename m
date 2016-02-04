From: will.deacon@arm.com (Will Deacon)
Date: Thu, 4 Feb 2016 11:33:45 +0000
Subject: [PATCH v2] drivers/perf: arm_pmu: make info messages more verbose
In-Reply-To: <1454579928-20231-1-git-send-email-dirk.behme@de.bosch.com>
References: <1454579928-20231-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20160204113343.GC17257@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 10:58:48AM +0100, Dirk Behme wrote:
> On a big.LITTLE system e.g. with Cortex A57 and A53 in case not all cores
> are online at PMU probe time we might get
> 
> hw perfevents: failed to probe PMU!
> hw perfevents: failed to register PMU devices!
> 
> making it unclear which cores failed, here.
> 
> Add the device tree full name which failed and the error value resulting
> in a more verbose and helpful message like
> 
> hw perfevents: /soc/pmu_a53: failed to probe PMU! Error -6
> hw perfevents: /soc/pmu_a53: failed to register PMU devices! Error -6
> 
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> ---
> Changes in v2: Use the full node name from DT instead of pmu->name, as if
> we fail to find anything in the match table, that'll be NULL. Additionally,
> add the error value to get an idea why it failed.
> 
>  drivers/perf/arm_pmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

This looks fine to me, but please can you rebase on top of my perf/updates
branch [1] so that I can queue it?

Cheers,

Will

[1] https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/log/?h=perf/updates
