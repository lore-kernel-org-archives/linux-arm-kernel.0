From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 12 Nov 2012 12:10:37 +0800
Subject: [PATCH] ARM: tegra: retain L2 content over CPU suspend/resume
In-Reply-To: <509D7BA1.506@wwwdotorg.org>
References: <1352194377-6209-1-git-send-email-josephl@nvidia.com>
 <509D7BA1.506@wwwdotorg.org>
Message-ID: <1352693437.19251.9.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-11-10 at 05:54 +0800, Stephen Warren wrote:
> On 11/06/2012 02:32 AM, Joseph Lo wrote:
> > The L2 RAM is in different power domain from the CPU cluster. So the
> > L2 content can be retained over CPU suspend/resume. To do that, we
> > need to disable L2 after the MMU is disabled, and enable L2 before
> > the MMU is enabled. But the L2 controller is in the same power domain
> > with the CPU cluster. We need to restore it's settings and re-enable
> > it after the power be resumed.
> 
> This doesn't compile:
> 
> arch/arm/mach-tegra/headsmp.S: Assembler messages:
> arch/arm/mach-tegra/headsmp.S:119: Error: undefined symbol L2X0_CTRL_EN
> used as an immediate value
> arch/arm/mach-tegra/headsmp.S:119: Error: undefined symbol L2X0_CTRL_EN
> used as an immediate value

Ah, sorry for mention that.
This patch was depended on "07bd005 ARM: 7547/1: cache-l2x0: add support
for Aurora L2 cache ctrl" and only showed up after "next-20121024". The
definition of "L2X0_CTRL_EN" was been introduced in that patch.

Should I re-send a patch that based on tegra "for-next" branch that will
change L2X0_CTRL_EN to 0x1? Sorry for inconvenience.

Thanks,
Joseph
