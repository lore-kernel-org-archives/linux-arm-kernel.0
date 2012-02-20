From: ccross@android.com (Colin Cross)
Date: Mon, 20 Feb 2012 15:13:10 -0800
Subject: [PATCH v3 02/10] ARM: tegra: export Tegra chipid
In-Reply-To: <1328831277-21002-3-git-send-email-pdeschrijver@nvidia.com>
References: <1328831277-21002-1-git-send-email-pdeschrijver@nvidia.com>
 <1328831277-21002-3-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <CAMbhsRT-ZTh7WQ1E0NUjX8FOMGAvx5zNnB-VYD=j8sWhM-9j+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 9, 2012 at 3:47 PM, Peter De Schrijver
<pdeschrijver@nvidia.com> wrote:
> The powergating and reset handling code needs to differentiate between Tegra
> variants. Therefore we export the chipid here.
>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
> ?arch/arm/mach-tegra/fuse.c | ? ?2 +-
> ?arch/arm/mach-tegra/fuse.h | ? ?1 +
> ?2 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
> index 032a936..3298880 100644
> --- a/arch/arm/mach-tegra/fuse.c
> +++ b/arch/arm/mach-tegra/fuse.c
> @@ -34,7 +34,7 @@
> ?int tegra_sku_id;
> ?int tegra_cpu_process_id;
> ?int tegra_core_process_id;
> -static int tegra_chip_id;
> +int tegra_chip_id;
> ?enum tegra_revision tegra_revision;
>
> ?/* The BCT to use at boot is specified by board straps that can be read
> diff --git a/arch/arm/mach-tegra/fuse.h b/arch/arm/mach-tegra/fuse.h
> index c554572..d2107b2 100644
> --- a/arch/arm/mach-tegra/fuse.h
> +++ b/arch/arm/mach-tegra/fuse.h
> @@ -41,6 +41,7 @@ enum tegra_revision {
> ?extern int tegra_sku_id;
> ?extern int tegra_cpu_process_id;
> ?extern int tegra_core_process_id;
> +extern int tegra_chip_id;
> ?extern enum tegra_revision tegra_revision;
>
> ?extern int tegra_bct_strapping;

Other platforms use accessors for this (cpu_is_xxx(), although
soc_is_xxx() is probably more appropriate).
