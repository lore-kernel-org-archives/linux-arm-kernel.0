From: dkos@cadence.com (Damian Kos)
Date: Thu, 13 Sep 2018 10:15:19 +0000
Subject: [PATCH v3 1/5] drm/rockchip: prepare common code for cdns and rk
 dpi/dp driver
In-Reply-To: <20180913100100eucas1p23e7e33035b6cba51d6219a58b34eea92~T7VgDpN8L3204732047eucas1p2_@eucas1p2.samsung.com>
References: <1535451894-2518-1-git-send-email-dkos@cadence.com>
 <CGME20180828102612epcas2p376fa6f21ce57f4753a8d0f80f5359842@epcas2p3.samsung.com>
 <1535451894-2518-2-git-send-email-dkos@cadence.com>
 <20180913100100eucas1p23e7e33035b6cba51d6219a58b34eea92~T7VgDpN8L3204732047eucas1p2_@eucas1p2.samsung.com>
Message-ID: <CO2PR07MB255146DAA1B87BB046E64BAECD1A0@CO2PR07MB2551.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you, Andrzej! I was a bit afraid that our patches are a bit too messy and thus ignored ?
Anyway, this patch (1/5) should be the last one that will cause such chaos in the DRM area.

Regards,
Damian

-----Original Message-----
From: Andrzej Hajda <a.hajda@samsung.com> 
Sent: Thursday, September 13, 2018 12:01
To: Damian Kos <dkos@cadence.com>; David Airlie <airlied@linux.ie>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Archit Taneja <architt@codeaurora.org>; Laurent Pinchart <Laurent.pinchart@ideasonboard.com>; Gustavo Padovan <gustavo@padovan.org>; Maarten Lankhorst <maarten.lankhorst@linux.intel.com>; Sean Paul <sean@poorly.run>; Sandy Huang <hjc@rock-chips.com>; Heiko St?bner <heiko@sntech.de>; Quentin Schulz <quentin.schulz@bootlin.com>; dri-devel at lists.freedesktop.org; devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-rockchip at lists.infradead.org
Cc: Przemyslaw Gaj <pgaj@cadence.com>; Lukasz Tyrala <ltyrala@cadence.com>; Scott Telford <stelford@cadence.com>; Artur Jedrysek <jartur@cadence.com>; Piotr Sroka <piotrs@cadence.com>
Subject: Re: [PATCH v3 1/5] drm/rockchip: prepare common code for cdns and rk dpi/dp driver

EXTERNAL MAIL


Hi Damian,

Quite late but.

On 28.08.2018 12:24, Damian Kos wrote:
> - Extracted common fields from cdn_dp_device to a new cdns_mhdp_device
>   structure which will be used by two separate drivers later on.
> - Moved some datatypes (audio_format, audio_info, vic_pxl_encoding_format,
>   video_info) from cdn-dp-core.c to cdn-dp-reg.h.
> - Changed prefixes from cdn_dp to cdns_mhdp
>     cdn -> cdns to match the other Cadence's drivers
>     dp -> mhdp to distinguish it from a "just a DP" as the IP underneath
>       this registers map can be a HDMI (which is internally different,
>       but the interface for commands, events is pretty much the same).
> - Modified cdn-dp-core.c to use the new driver structure and new function
>   names.
>
> Signed-off-by: Damian Kos <dkos@cadence.com>

Many changes, hard to review. Anyway:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

?--
Regards
Andrzej
