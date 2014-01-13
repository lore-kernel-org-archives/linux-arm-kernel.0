From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 13 Jan 2014 15:02:10 -0700
Subject: [BUILD BUG] tegra-powergate
In-Reply-To: <20140113183727.GD15937@n2100.arm.linux.org.uk>
References: <20140113183727.GD15937@n2100.arm.linux.org.uk>
Message-ID: <52D46262.20409@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2014 11:37 AM, Russell King - ARM Linux wrote:
> One of the randconfigs found this:
> 
> In file included from drivers/gpu/drm/tegra/gr3d.c:15:0:
> include/linux/tegra-powergate.h:119:1: error: expected identifier or '(' before '{' token
> 
> static inline int tegra_powergate_sequence_power_up(int id, struct clk *clk,
>                                                     struct reset_control *rst);
> {
> 
> That semicolon should not be there.

Thanks for the heads-up. I sent a patch to fix this.
