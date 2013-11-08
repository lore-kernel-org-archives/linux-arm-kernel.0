From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 Nov 2013 15:57:17 +0000
Subject: [PATCH 2/2] arm64: perf: add support for percpu pmu interrupt
In-Reply-To: <1383739658-10036-3-git-send-email-vkale@apm.com>
References: <1383739658-10036-1-git-send-email-vkale@apm.com>
 <1383739658-10036-3-git-send-email-vkale@apm.com>
Message-ID: <20131108155717.GB15074@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 12:07:37PM +0000, Vinayak Kale wrote:
> Add support for irq registration when pmu interrupt is percpu.
> 
> Signed-off-by: Vinayak Kale <vkale@apm.com>
> Signed-off-by: Tuan Phan <tphan@apm.com>
> ---
>  arch/arm64/kernel/perf_event.c |  109 +++++++++++++++++++++++++++++-----------
>  1 file changed, 81 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index cea1594..e60dae3 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -44,6 +44,7 @@
>  static DEFINE_PER_CPU(struct perf_event * [ARMPMU_MAX_HWEVENTS], hw_events);
>  static DEFINE_PER_CPU(unsigned long [BITS_TO_LONGS(ARMPMU_MAX_HWEVENTS)], used_mask);
>  static DEFINE_PER_CPU(struct pmu_hw_events, cpu_hw_events);
> +static bool is_percpuirq;

This isn't a global property; it should be part of the struct arm_pmu.
The rest of the patch looks ok, but obvious requires you to merge the core
changes first.

Will
