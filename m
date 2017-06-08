From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 8 Jun 2017 10:55:16 +0530
Subject: [PATCH 1/2] ARM: davinci: pdata-quirks: fix const warnings
In-Reply-To: <20170602231210.19553-2-khilman@baylibre.com>
References: <20170602231210.19553-1-khilman@baylibre.com>
 <20170602231210.19553-2-khilman@baylibre.com>
Message-ID: <5144c8fc-06a8-1d85-0bd3-2640d0903d5c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Saturday 03 June 2017 04:42 AM, Kevin Hilman wrote:
> After VPIF was converted to enable getting subdevs from DT, the
> pdata is no longer const, so remove these to avoid compiler warnings.
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

I think this should be squashed into patch 2/4 of "davinci:
vpif_capture: raw camera support" series where the warning is
introduced. That does mix the platform and driver parts in one patch,
but I think its better that way so that no patch introduces a warning.

The patch does not clash with anything queued in davinci tree, so I
think it should be fine.

Also, there is a warning introduced in
arch/arm/mach-davinci/board-dm646x-evm.c that should be fixed as well.

Thanks,
Sekhar
