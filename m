From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 09 Nov 2012 14:54:41 -0700
Subject: [PATCH] ARM: tegra: retain L2 content over CPU suspend/resume
In-Reply-To: <1352194377-6209-1-git-send-email-josephl@nvidia.com>
References: <1352194377-6209-1-git-send-email-josephl@nvidia.com>
Message-ID: <509D7BA1.506@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2012 02:32 AM, Joseph Lo wrote:
> The L2 RAM is in different power domain from the CPU cluster. So the
> L2 content can be retained over CPU suspend/resume. To do that, we
> need to disable L2 after the MMU is disabled, and enable L2 before
> the MMU is enabled. But the L2 controller is in the same power domain
> with the CPU cluster. We need to restore it's settings and re-enable
> it after the power be resumed.

This doesn't compile:

arch/arm/mach-tegra/headsmp.S: Assembler messages:
arch/arm/mach-tegra/headsmp.S:119: Error: undefined symbol L2X0_CTRL_EN
used as an immediate value
arch/arm/mach-tegra/headsmp.S:119: Error: undefined symbol L2X0_CTRL_EN
used as an immediate value
