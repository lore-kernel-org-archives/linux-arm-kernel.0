From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 30 Nov 2014 12:49:46 +0100
Subject: [PATCH v5 0/6] exynos: Move pmu driver to driver/soc folder and
 add exynos7 support
In-Reply-To: <1417270508-11174-1-git-send-email-amit.daniel@samsung.com>
References: <1417270508-11174-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <2615519.HqpqtJvKZ1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 29 November 2014 19:45:02 Amit Daniel Kachhap wrote:
> This patch series [1 - 6] performs,
> 
> 1) Moves pmu driver to driver/soc/samsung folder. This is needed as exynos7 is
>    an arm64 based platform and hence PMU driver should be in driver folder.
>    Some discussion happened about this in the v1 version. Finally adding it in
>    driver/soc folder as it too SoC specific and not a general driver.
>    Entire discussion can be found here (A).
> 2) Add exynos7 PMU support.
> 3) Enables the driver for 32bit arm exynos platforms.
> 
> TODO: There is some suggestion to split the PMU data for 32 bit and 64 bit
> Exynos SOC. This can be implemented as a separate optimization patches.
> Submitting this version without much change from previous version as the merge
> window is near.

I only now saw this series. I think it's a bad idea to have this code shared
with arm64 at all, and I want to see a proper driver for the PMU.

	Arnd
