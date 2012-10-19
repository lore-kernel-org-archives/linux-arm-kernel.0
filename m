From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 19 Oct 2012 14:43:50 +0530
Subject: [PATCH 3/5] ARM: tegra: fix clock entry of slink controller
In-Reply-To: <5080862C.9030203@wwwdotorg.org>
References: <1350557795-31487-1-git-send-email-ldewangan@nvidia.com>
 <1350557795-31487-4-git-send-email-ldewangan@nvidia.com>
 <5080862C.9030203@wwwdotorg.org>
Message-ID: <508119CE.9070408@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 October 2012 04:13 AM, Stephen Warren wrote:
>
> The patch subject isn't entirely accurate here; this patch isn't just
> about fixing clock entries.
>

OK, then  will break in two patches.

>
>> +	OF_DEV_AUXDATA("nvidia,tegra20-slink", TEGRA_SLINK1_BASE, "spi-tegra-slink.0", NULL),
> Here, can't we just use the existing device names in the clock files...
>
> So we can completely drop the changes to these two files:
>
I want to name the driver as spi-tegra-slink. When we add the sflash spi 
driver for tegra20, the driver name will be spi-tegra-sflash.
Also current name is "spi_tegra" I do not want to name with "_". So it 
is require to convert as "-".



>> diff --git a/arch/arm/mach-tegra/tegra20_clocks_data.c b/arch/arm/mach-tegra/tegra20_clocks_data.c
>> diff --git a/arch/arm/mach-tegra/tegra30_clocks_data.c b/arch/arm/mach-tegra/tegra30_clocks_data.c
> The device names will hopefully be irrelevant once we're able to use
> DT-based clock lookups.
Agree, but currently we can add this to have progress.
