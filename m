From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 30 Mar 2011 12:15:26 +0530
Subject: [PATCH 0/5] OMAP: l3: fixes and cleanup
In-Reply-To: <1301419219-30547-1-git-send-email-omar.ramirez@ti.com>
References: <1301419219-30547-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <4D92D186.1070302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Omar,

On 3/29/2011 10:50 PM, Omar Ramirez Luna wrote:
> Based on the comments received for the first patch:
> OMAP3: l3: fix for "irq 10: nobody cared" message[1],
> and quick skimming through the code.
>
> Although there are still parenthesis that are not needed
> because of operator precedence, they were left for clarity.
>
> E.g.:
> (error>>  32)&  0xffff;
>
> clear = (L3_AGENT_STATUS_CLEAR_IA<<  int_type) |
>          L3_AGENT_STATUS_CLEAR_TA;
>
> ---
> [1] https://patchwork.kernel.org/patch/665141/
>
> Omar Ramirez Luna (5):
>    OMAP3: l3: fix for "irq 10: nobody cared" message
>    OMAP3: l3: fix omap3_l3_probe error path
>    OMAP3: l3: minor cleanup for error message, parenthesis and extra
>      lines
>    OMAP4: l3: fix omap4_l3_probe error path
>    OMAP4: l3: minor cleanup for parenthesis and extra spaces
>
Thanks for the cleanup. I have reviewed the series and it looks
good to me.
I would suggest to fold similar changes like,
- PATCH 2/5 and PATCH 4/5 into one patch
- PATCH 3/5 and PATCH 5/5 into one patch

With this update you can add my ack for this series

>   arch/arm/mach-omap2/omap_l3_noc.c |   51 ++++++++++++++++--------------------
>   arch/arm/mach-omap2/omap_l3_smx.c |   46 ++++++++++++---------------------
>   2 files changed, 40 insertions(+), 57 deletions(-)
>
