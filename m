From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 14 Mar 2018 11:33:37 +0100
Subject: [PATCH 1/4] ARM: dts: exynos5250: Add #sound-dai-cells property
 to hdmi device node
In-Reply-To: <5AA5CE4F.6050807@samsung.com>
References: <CGME20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56@epcas1p1.samsung.com>
 <20180307172711.15697-1-s.nawrocki@samsung.com>
 <5AA1F41B.5080104@samsung.com>
 <39965bce-a6f2-6202-5c3f-97e4446e97eb@samsung.com>
 <5AA5CE4F.6050807@samsung.com>
Message-ID: <21459bbe-befc-da77-5c34-c821db74ae8d@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Inki,

On 03/12/2018 01:48 AM, Inki Dae wrote:
> Thanks for explanation. By the way, who binds '#sound-dai-cells' property?.
> This patch adds this property to hdmi device node which will be bound by 
> HDMI driver fo Exynos DRM but I don't see any place to bind '#sound-dai-cells' 
> property in this driver.
> So I think some driver like Odroid XU3/4 audio driver(sound/soc/samsung/odroid.c) 
> or ASoC simple audio card driver(sound/soc/generic/simple-card.c) should exist 
> and this property should be placed to such device node.

The *-cells property is supposed to be in a node that a phandle points to,
and in this case the phandle entry in 'sound-dai' points to the hdmi node.
>From the DT bindings perspective it not that important how Linux parses
the bindings, it's more a matter of describing the HW configuration.

There is even a related check in dtc:

$ grep -n sound scripts/dtc/checks.c
1208:WARNING_PROPERTY_PHANDLE_CELLS(sound_dai, "sound-dai", "#sound-dai-cells");

-- 
Regards,
Sylwester
