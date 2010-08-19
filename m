From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 19 Aug 2010 11:29:27 -0700
Subject: [PATCH 3/3] davinci: Map sram using MT_MEMORY_NONCACHED instead
	of MT_DEVICE
In-Reply-To: <1281262702-27732-1-git-send-email-santosh.shilimkar@ti.com>
References: <1281262702-27732-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <AANLkTi=9k19RUmfnNBO8AfFj_LtyNtsPPVYC_=-AW5yE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 8, 2010 at 3:18 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On Davinci SRAM is mapped as MT_DEVICE becasue of the section
> mapping pre-requisite instead of intended MT_MEMORY_NONCACHED
>
> Since the section mapping limitation gets fixed with first
> patch in this series, the MT_MEMORY_NONCACHED can be used now.
>
> Have not tested this, so somebody with Davinci hardware can
> try this out
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
> ?arch/arm/mach-davinci/dm355.c ?| ? ?3 +--
> ?arch/arm/mach-davinci/dm365.c ?| ? ?3 +--
> ?arch/arm/mach-davinci/dm644x.c | ? ?3 +--
> ?arch/arm/mach-davinci/dm646x.c | ? ?3 +--
> ?4 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
> index 3834781..e7bd2ad 100644
> --- a/arch/arm/mach-davinci/dm355.c
> +++ b/arch/arm/mach-davinci/dm355.c
> @@ -767,8 +767,7 @@ static struct map_desc dm355_io_desc[] = {
> ? ? ? ? ? ? ? ?.virtual ? ? ? ?= SRAM_VIRT,
> ? ? ? ? ? ? ? ?.pfn ? ? ? ? ? ?= __phys_to_pfn(0x00010000),
> ? ? ? ? ? ? ? ?.length ? ? ? ? = SZ_32K,
> - ? ? ? ? ? ? ? /* MT_MEMORY_NONCACHED requires supersection alignment */
> - ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
> + ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_MEMORY_NONCACHED,
> ? ? ? ?},
> ?};
>
> diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
> index a146849..5dee032 100644
> --- a/arch/arm/mach-davinci/dm365.c
> +++ b/arch/arm/mach-davinci/dm365.c
> @@ -967,8 +967,7 @@ static struct map_desc dm365_io_desc[] = {
> ? ? ? ? ? ? ? ?.virtual ? ? ? ?= SRAM_VIRT,
> ? ? ? ? ? ? ? ?.pfn ? ? ? ? ? ?= __phys_to_pfn(0x00010000),
> ? ? ? ? ? ? ? ?.length ? ? ? ? = SZ_32K,
> - ? ? ? ? ? ? ? /* MT_MEMORY_NONCACHED requires supersection alignment */
> - ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
> + ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_MEMORY_NONCACHED,
> ? ? ? ?},
> ?};
>
> diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
> index 7ad1520..5112d51 100644
> --- a/arch/arm/mach-davinci/dm644x.c
> +++ b/arch/arm/mach-davinci/dm644x.c
> @@ -651,8 +651,7 @@ static struct map_desc dm644x_io_desc[] = {
> ? ? ? ? ? ? ? ?.virtual ? ? ? ?= SRAM_VIRT,
> ? ? ? ? ? ? ? ?.pfn ? ? ? ? ? ?= __phys_to_pfn(0x00008000),
> ? ? ? ? ? ? ? ?.length ? ? ? ? = SZ_16K,
> - ? ? ? ? ? ? ? /* MT_MEMORY_NONCACHED requires supersection alignment */
> - ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
> + ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_MEMORY_NONCACHED,
> ? ? ? ?},
> ?};
>
> diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
> index 9404565..97078f4 100644
> --- a/arch/arm/mach-davinci/dm646x.c
> +++ b/arch/arm/mach-davinci/dm646x.c
> @@ -735,8 +735,7 @@ static struct map_desc dm646x_io_desc[] = {
> ? ? ? ? ? ? ? ?.virtual ? ? ? ?= SRAM_VIRT,
> ? ? ? ? ? ? ? ?.pfn ? ? ? ? ? ?= __phys_to_pfn(0x00010000),
> ? ? ? ? ? ? ? ?.length ? ? ? ? = SZ_32K,
> - ? ? ? ? ? ? ? /* MT_MEMORY_NONCACHED requires supersection alignment */
> - ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
> + ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_MEMORY_NONCACHED,
> ? ? ? ?},
> ?};
>
> --
> 1.6.0.4
>
>
