From: robh@kernel.org (Rob Herring)
Date: Tue, 22 May 2018 17:31:33 -0500
Subject: [PATCH 2/2] soc: bcm: brcmstb: Add missing DDR MEMC compatible
 strings
In-Reply-To: <20180511220242.837-3-f.fainelli@gmail.com>
References: <20180511220242.837-1-f.fainelli@gmail.com>
 <20180511220242.837-3-f.fainelli@gmail.com>
Message-ID: <20180522223133.GA11292@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 03:02:42PM -0700, Florian Fainelli wrote:
> We would not be matching the following chip/compatible strings
> combinations, which would lead to not setting the warm boot flag
> correctly, fix that:
> 
>     7260A0/B0: brcm,brcmstb-memc-ddr-rev-b.2.1
>     7255A0: brcm,brcmstb-memc-ddr-rev-b.2.3
>     7278Bx: brcm,brcmstb-memc-ddr-rev-b.3.1
> 
> The B2.1 core (which is in 7260 A0 and B0) doesn't have the
> SHIMPHY_ADDR_CNTL_0_DDR_PAD_CNTRL setup in the memsys init code, nor
> does it have the warm boot flag re-definition on entry. Those changes
> were for B2.2 and later MEMSYS cores. Fall back to the previous S2/S3
> entry method for these specific chips.
> 
> Fixes: 0b741b8234c8 ("soc: bcm: brcmstb: Add support for S2/S3/S5 suspend states (ARM)")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt |  3 +++
>  drivers/soc/bcm/brcmstb/pm/pm-arm.c                        | 12 ++++++++++++
>  2 files changed, 15 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
