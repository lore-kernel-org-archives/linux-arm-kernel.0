From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 11 May 2016 11:44:33 +0300
Subject: [PATCH v3 0/7] ARM/ASoC: OMAP3: Fix McBSP2/3 sidetone support
In-Reply-To: <1461927202-17677-1-git-send-email-peter.ujfalusi@ti.com>
References: <1461927202-17677-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <69ff65ee-e5d1-09fb-fd91-8d7b4d8fdda4@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony, Paul,

On 04/29/16 13:53, Peter Ujfalusi wrote:
> Hi,
> 
> Based on the ongoing discussion on v2 (ARM: OMAP3: Fix McBSP2/3 hwmod setup for
> sidetone) I have dropped the removal of the sidetone hwmod and only corrected
> it. The series now includes all related changes needed to have correct sidetone
> support whenever we boot in legacy or in DT mode.
> 
> This time the ASoC part have dependency on earlier patches so they can not be
> applied separately.

How should we proceed from here? I don't want to start designing the ST
separation infrastructure which would be based on this series, but if there
are outstanding issues found on this, I would need to go back to the drawing
board.
The separation will be mostly new code and code shuffle in ASoC, but for
legacy I will need to build up something in arch as well, so I would need at
least one release cycle to start with things.

-- 
P?ter

> Regards,
> Peter
> ---
> Peter Ujfalusi (7):
>   ARM: OMAP3: hwmod data: Fix McBSP2/3 sidetone data
>   ARM: dts: omap3: Add clocks to McBSP nodes
>   ARM: OMAP3: McBSP: New callback for McBSP2/3 ICLK idle configuration
>   ARM: OMAP3: pdata-quirks: Add support for McBSP2/3 sidetone handling
>   ASoc: omap-mcbsp: Rename omap_mcbsp_sysfs_remove() to
>     omap_mcbsp_cleanup()
>   ASoC: omap-mcbsp: sidetone: Use the new callback for iclk handling
>   ARM: OMAP2+: McBSP: Remove the old iclk allow/deny idle code
> 
>  arch/arm/boot/dts/omap3.dtsi                | 10 ++++++++++
>  arch/arm/mach-omap2/mcbsp.c                 | 31 ++++++++++++++++-------------
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c  | 24 ++++------------------
>  arch/arm/mach-omap2/pdata-quirks.c          | 18 +++++++++++++++++
>  include/linux/platform_data/asoc-ti-mcbsp.h |  4 +++-
>  sound/soc/omap/mcbsp.c                      | 21 +++++++++++++------
>  sound/soc/omap/mcbsp.h                      |  3 ++-
>  sound/soc/omap/omap-mcbsp.c                 |  5 ++++-
>  8 files changed, 73 insertions(+), 43 deletions(-)
> 
