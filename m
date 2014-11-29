From: kgene@kernel.org (Kukjin Kim)
Date: Sun, 30 Nov 2014 08:35:26 +0900
Subject: [PATCH v5 5/6] drivers: soc: exynos-pmu: Add support for Exynos7
In-Reply-To: <1417270508-11174-6-git-send-email-amit.daniel@samsung.com>
References: <1417270508-11174-1-git-send-email-amit.daniel@samsung.com>
 <1417270508-11174-6-git-send-email-amit.daniel@samsung.com>
Message-ID: <02b001d00c2d$27410aa0$75c31fe0$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amit Daniel Kachhap wrote:
> 
> Add PMU settings for exynos7. This is required for future suspend-to-ram,
> cpuidle and power domain support.
> 
> Note: In this patch some static declarations lines are over 80
> characters per line for easy redability.
> 
> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Eunseok Choi <es10.choi@samsung.com>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  drivers/soc/samsung/exynos-pmu.c            |  427 ++++++++++++++++++++++++++-
>  include/linux/soc/samsung/exynos-regs-pmu.h |  273 +++++++++++++++++
>  2 files changed, 699 insertions(+), 1 deletion(-)
> 
I'm not sure all of the definitions in exynos-regs-pmu are required?...too many,
and I couldn't check the addresses are correct ;)

And how about splitting to each SoC specific file in drivers/soc/samsung/ ?
For example, exynos-pmu.c and exynos7-pmu.c like cpufreq...? Just considering.

- Kukjin
