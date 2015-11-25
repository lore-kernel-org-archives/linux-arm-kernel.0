From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 25 Nov 2015 17:03:13 +0800
Subject: [PATCH] ASoC: rockchip: Fix incorrect VDW value for 24 bit
In-Reply-To: <1448441651-444-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1448441651-444-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <56557951.7070401@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

? 2015?11?25? 16:54, Sjoerd Simons ??:
> Correct valid data word register value for 24 bit data width. The
> bit value should be 10 (aka 0x2), not 0x10.
>
> This fixes playback of 24 bit audio.
>
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
>
> ---
>
>   sound/soc/rockchip/rockchip_spdif.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/rockchip/rockchip_spdif.h b/sound/soc/rockchip/rockchip_spdif.h
> index 07f86a2..921b409 100644
> --- a/sound/soc/rockchip/rockchip_spdif.h
> +++ b/sound/soc/rockchip/rockchip_spdif.h
> @@ -28,9 +28,9 @@
>   #define SPDIF_CFGR_VDW(x)	(x << SPDIF_CFGR_VDW_SHIFT)
>   #define SDPIF_CFGR_VDW_MASK	(0xf << SPDIF_CFGR_VDW_SHIFT)
>   
> -#define SPDIF_CFGR_VDW_16	SPDIF_CFGR_VDW(0x00)
> -#define SPDIF_CFGR_VDW_20	SPDIF_CFGR_VDW(0x01)
> -#define SPDIF_CFGR_VDW_24	SPDIF_CFGR_VDW(0x10)
> +#define SPDIF_CFGR_VDW_16	SPDIF_CFGR_VDW(0x0)
> +#define SPDIF_CFGR_VDW_20	SPDIF_CFGR_VDW(0x1)
> +#define SPDIF_CFGR_VDW_24	SPDIF_CFGR_VDW(0x2)

Yep,
 From the TRM says: (RK3288/RK3368...)

VDW
Valid data width
00: 16bit
01: 20bit
10: 24bit
11: reserved
....

So feel free add my tag:

Reviewed-by: Caesar Wang <wxt@rock-chips.com>


>   
>   /*
>    * DMACR


-- 
caesar wang | software engineer | wxt at rock-chip.com
