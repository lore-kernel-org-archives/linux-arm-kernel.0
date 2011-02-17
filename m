From: sumit.semwal@ti.com (Semwal, Sumit)
Date: Thu, 17 Feb 2011 20:32:43 +0530
Subject: [PATCH 4/8] OMAP4: hwmod data: Add DSS, DISPC, DSI1&2, RFBI, HDMI
	and VENC
In-Reply-To: <1297938289-8678-5-git-send-email-b-cousson@ti.com>
References: <1297938289-8678-1-git-send-email-b-cousson@ti.com>
	<1297938289-8678-5-git-send-email-b-cousson@ti.com>
Message-ID: <AANLkTimPxP2dN-xgKhTwFwo-iPcgJ9gRSYAFF3=TLap1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

One minor comment;

On Thu, Feb 17, 2011 at 3:54 PM, Benoit Cousson <b-cousson@ti.com> wrote:
> Add dss, dispc, dsi1, dsi2, hdmi, rfbi and venc hwmods.
> In OMAP4 there are severals IPs that can be reached by differents
> interconnect paths depending of the access initiator (MPU vs. SDMA).
> In the case of the DSS, both L3 direct path and L4 CFG path can be
> used to access all the DSS IPs. The two ocp_ip already exists to support
> the two address spaces.
>
> ? ? ?+------------+-- L3_MAIN --+ MPU
> ?IP ?| ? ? ? ? ? ?|
> ? ? ?+-- L4_CFG --+
>
> L3 main address range is specified first, since it is used by default.
> dss is also considered as an IP as dispc, rfbi, and named as dss_core.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
> [b-cousson at ti.com: Re-organize structures to match file
> convention and remove irq entry from dss_hwmod]
> ---
> ?arch/arm/mach-omap2/omap_hwmod_44xx_data.c | ?612 +++++++++++++++++++++++++++-
> ?1 files changed, 604 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 37b3024..aafe60d 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -1,7 +1,7 @@
> ?/*
> ?* Hardware modules present on the OMAP44xx chips
> ?*
> - * Copyright (C) 2009-2010 Texas Instruments, Inc.
> + * Copyright (C) 2009-2011 Texas Instruments, Inc.
> ?* Copyright (C) 2009-2010 Nokia Corporation
> ?*
> ?* Paul Walmsley
> @@ -43,6 +43,7 @@
> ?static struct omap_hwmod omap44xx_dma_system_hwmod;
> ?static struct omap_hwmod omap44xx_dmm_hwmod;
> ?static struct omap_hwmod omap44xx_dsp_hwmod;
> +static struct omap_hwmod omap44xx_dss_hwmod;
I guess we agreed to name this dss_core - any specific reason to change it?

Best regards,
~Sumit.
<snip>
