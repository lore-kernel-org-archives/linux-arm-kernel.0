From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 14 May 2013 00:30:27 +0200
Subject: [PATCH 2/2] ARM: shmobile: lager: enable Ether
In-Reply-To: <5190E4E9.20100@cogentembedded.com>
References: <1368173119-27345-1-git-send-email-horms+renesas@verge.net.au>
 <20130513004001.GC22911@verge.net.au> <5190E4E9.20100@cogentembedded.com>
Message-ID: <4649393.HiDLOXMspX@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 May 2013 17:04:41 Sergei Shtylyov wrote:
> On 13.05.2013 4:40, Simon Horman wrote:
> > [ CC Laurent ]
> > 
> >>> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >>> 
> >>> ---
> >>> 
> >>> This patch has a run-time dependency on "sh_eth: add support for r8a7790
> >>> SoC".
> [...]
> 
> >>> diff --git a/arch/arm/mach-shmobile/board-lager.c
> >>> b/arch/arm/mach-shmobile/board-lager.c index 6a1ba38..0b8112d 100644
> >>> --- a/arch/arm/mach-shmobile/board-lager.c
> >>> +++ b/arch/arm/mach-shmobile/board-lager.c
> >> 
> >> [...]
> >> 
> >>> @@ -59,6 +69,17 @@ static const struct pinctrl_map lager_pinctrl_map[] =
> >>> {
> >>> 
> >>>   	/* SCIF1 (CN20: DEBUG SERIAL1) */
> >>>   	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.7", "pfc-r8a7790",
> >>>   	
> >>>   				  "scif1_data", "scif1"),
> >>> 
> >>> +	/* Ether */
> >>> +	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
> >>> +				  "eth_link", "eth"),
> >>> +	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
> >>> +				  "eth_magic", "eth"),
> >>> +	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
> >>> +				  "eth_mdio", "eth"),
> >>> +	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7790",
> >>> +				  "eth_rmii", "eth"),
> >>> 
> >>      I thought MDIO bus was a part of RMII. At least Wikipedia told
> >> 
> >> me so. :-)
> > 
> > Is the implication that you think that the eth_mdio and eth_rmii
> > groups should be combined?

MDIO is used by RMII, MII and (R)GMII. Merging eth_mdio and eth_rmii would 
require duplicating the pins in all those ethernet-related functions.

-- 
Regards,

Laurent Pinchart
