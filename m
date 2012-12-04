From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Tue, 4 Dec 2012 10:42:38 +0530
Subject: [PATCH 2/5] ARM: tegra20: clocks: add CPU low-power function
 into tegra_cpu_car_ops
In-Reply-To: <1354503607-13707-3-git-send-email-josephl@nvidia.com>
References: <1354503607-13707-1-git-send-email-josephl@nvidia.com>
 <1354503607-13707-3-git-send-email-josephl@nvidia.com>
Message-ID: <50BD8646.6070608@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 December 2012 08:30 AM, Joseph Lo wrote:
> Add suspend, resume and rail_off_ready API into tegra_cpu_car_ops. These
> functions were used for CPU powered-down state maintenance.
>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>   arch/arm/mach-tegra/tegra20_clocks.c |  102 ++++++++++++++++++++++++++++++++++
>   1 files changed, 102 insertions(+), 0 deletions(-)

I have a concern here, I am working on removing these ops and replacing 
it with clock.
Adding suspend/resume to these will make it more difficult to remove.

Any other way to implement this?

> diff --git a/arch/arm/mach-tegra/tegra20_clocks.c b/arch/arm/mach-tegra/tegra20_clocks.c
> index 4eb6bc8..05968d7 100644
> --- a/arch/arm/mach-tegra/tegra20_clocks.c
> +++ b/arch/arm/mach-tegra/tegra20_clocks.c
> @@ -159,6 +159,31 @@
>   #define CPU_CLOCK(cpu)	(0x1 << (8 + cpu))
>   #define CPU_RESET(cpu)	(0x1111ul << (cpu))
>   
