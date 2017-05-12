From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 12 May 2017 08:33:55 +0800
Subject: [PATCH v2] ARM: dts: imx6sx-sdb: Remove OPP override
In-Reply-To: <7b929a65b4893e081c2c04bb0588801f37ac2cca.1493981825.git.leonard.crestez@nxp.com>
References: <7b929a65b4893e081c2c04bb0588801f37ac2cca.1493981825.git.leonard.crestez@nxp.com>
Message-ID: <20170512003354.GA8471@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 05, 2017 at 02:00:17PM +0300, Leonard Crestez wrote:
> The board file for imx6sx-sdb overrides cpufreq operating points to use
> higher voltages. This is done because the board has a shared rail for
> VDD_ARM_IN and VDD_SOC_IN and when using LDO bypass the shared voltage
> needs to be a value suitable for both ARM and SOC.
> 
> This only applies to LDO bypass mode, a feature not present in upstream.
> When LDOs are enabled the effect is to use higher voltages than necessary
> for no good reason.
> 
> Setting these higher voltages can make some boards fail to boot with ugly
> semi-random crashes reminiscent of memory corruption. These failures only
> happen on board rev. C, rev. B is reported to still work.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> CC: stable at vger.kernel.org

Applied, thanks.
