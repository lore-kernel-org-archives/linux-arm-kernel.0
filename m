From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 11 Apr 2016 13:15:37 +0900
Subject: [PATCH 0/7] PM / devfreq: Add NoCP devfreq-event and support
 busfreq on exyno5422-odroidxu3
In-Reply-To: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <570B24E9.5020708@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

On 2016? 04? 08? 14:00, Chanwoo Choi wrote:
> This patchset support the AMBA bus frequency scaling on Exynos5422-based
> Odroid-XU3 board. But, this series only support the bus frequency scaling
> for INT (Internal) block using VDD_INT power line.
> 
> Also, to support the bus frequency scaling for Exynos542x SoC,
> Exynos542x SoC has the specific 'NoC (Network on Chip) Probe' device
> to measure the transfered data traffic on NoC (Network on Chip)
> instead of PPMU (Platform Performance Monitoring Unit). NoC Probe device
> provide the utilization for INT block of Exynos542x SoC.
> 
> The generic exynos-bus frequency driver uses the 'NoC Probe' devfreq-event
> device (drivers/devfreq/event/exynos-nocp.c) without any modification.
> Just add the phandle of 'NoC Probe' dt node to bus dt node.
> 
> Depend on:
> This patchset depends on patch[1] which support the generic exynos-bus
> frequency driver.
> 
> [1] https://lkml.org/lkml/2016/4/8/14
> - [PATCH v8 00/20] PM / devferq: Add generic exynos bus frequency driver and new passive governor

The dependency of these patch-set is changed from patches[1] to patches[2].
Because patches[1] has the possible recursive locking issue. Patches[2] fix this issue.

[2] http://www.spinics.net/lists/arm-kernel/msg495976.html
- [PATCH v9 00/20] PM / devferq: Add generic exynos bus frequency driver and new passive governor

[snip]

Best Regards,
Chanwoo Choi
