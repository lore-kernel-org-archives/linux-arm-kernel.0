From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 May 2014 14:51:22 +0200
Subject: [PATCH v4 0/8] cpufreq: use cpufreq-cpu0 driver for exynos based
 platforms
In-Reply-To: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
References: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <7170433.Ah6fefFrHR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 May 2014 06:41:08 Thomas Abraham wrote:
> 
> The patch series removes the use of Exynos specific cpufreq driver and enables
> the use of cpufreq-cpu0 driver for Exynos4210, Exynos4x12 and Exynos5250 based
> platforms. This is being done for few reasons.
> 
> (a) The Exynos cpufreq driver reads/writes clock controller registers
>     bypassing the Exynos CCF driver which is sort of problematic.
> (b) Removes the need for having clock controller register definitions
>     in the cpufreq driver and also removes the need for statically
>     io-remapping clock controller address space (helps in moving towards
>     multiplatform kernel).
> 

Thanks a lot for your continued effort. Looks great overall, but I have one
comment about the general way the cpu0 cpufreq driver works, not specific
to the exynos implementation. See my reply to patch 4.

	Arnd
