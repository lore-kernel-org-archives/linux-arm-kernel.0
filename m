From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 20 Sep 2016 12:59:19 -0700
Subject: [PATCH] clk: mvebu: Add clk support for the orion5x SoC mv88f5181
In-Reply-To: <20160920162450.4046-1-gregory.clement@free-electrons.com>
References: <20160920162450.4046-1-gregory.clement@free-electrons.com>
Message-ID: <20160920195919.GD8319@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20, Gregory CLEMENT wrote:
> From: Jamie Lentin <jm@lentin.co.uk>
> 
> Referring to the u-boot sources for the Netgear WNR854T, add support
> for the mv88f5181.
> 
> [gregory.clement at free-electrons.com: fix commit title]
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> 
> Hi Stephen and Mike,
> 
> do you agree to give your acked-by on this patch. It is part of a
> convertion of old orion5x Socv to the device tree. If you acked-by
> this one, then I will be able to take it in my tree and avoiding
> breaking the git bisect.

Is the problem that we're changing some dts files somewhere and
those platforms would stop booting if this change wasn't present?
Given that we're adding a new compatible it seems like we're
adding new SoC support, so having the clk patch and the dts patch
come together in -next via a merge instead of basing the dts
patch on top of the clk patch would be how things are normally
done.

If we're really changing some dts to be backwards incompatible,
then I understand the bisect problem and you can have my ack.

Acked-by: Stephen Boyd <sboyd@codeaurora.org.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
