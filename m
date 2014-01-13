From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jan 2014 18:37:27 +0000
Subject: [BUILD BUG] tegra-powergate
Message-ID: <20140113183727.GD15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the randconfigs found this:

In file included from drivers/gpu/drm/tegra/gr3d.c:15:0:
include/linux/tegra-powergate.h:119:1: error: expected identifier or '(' before '{' token

static inline int tegra_powergate_sequence_power_up(int id, struct clk *clk,
                                                    struct reset_control *rst);
{

That semicolon should not be there.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
