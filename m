From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Jul 2014 19:06:48 +0100
Subject: [PATCH 7/8] arm: perf: add more specific platform device IDs
In-Reply-To: <1404227478-9645-8-git-send-email-mark.rutland@arm.com>
References: <1404227478-9645-1-git-send-email-mark.rutland@arm.com>
 <1404227478-9645-8-git-send-email-mark.rutland@arm.com>
Message-ID: <20140701180648.GY28164@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 04:11:17PM +0100, Mark Rutland wrote:
> When described in DT, PMUs are given very specific compatible strings
> (e.g. "arm,cortex-a15-pmu") which makes it very easy to reorganise the
> way individual PMUs are handled (i.e. we can easily split them into
> separate drivers). The same is not true of PMUs described in board
> files, which are all use the platform_device_id "arm-pmu" and must all
> be handled by the same driver.
> 
> To enable splitting the ARMv6, ARMv7, and XScale PMU drivers we need
> board files to identify which variant they provide. As a first step,
> this patch adds new platform_device_id values: "armv6-pmu", "armv7-pmu,
> and "xscale-pmu".
> 
> Once board files are moved over and all existing uses of "arm-pmu" are
> gone, we can split the existing driver apart.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/kernel/perf_event_cpu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
> index 191aff0..c63dc42 100644
> --- a/arch/arm/kernel/perf_event_cpu.c
> +++ b/arch/arm/kernel/perf_event_cpu.c
> @@ -241,6 +241,9 @@ static struct of_device_id cpu_pmu_of_device_ids[] = {
>  
>  static struct platform_device_id cpu_pmu_plat_device_ids[] = {
>  	{.name = "arm-pmu"},
> +	{.name = "armv6-pmu"},
> +	{.name = "armv7-pmu"},
> +	{.name = "xscale-pmu"},

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
