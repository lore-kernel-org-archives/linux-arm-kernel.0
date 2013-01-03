From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 03 Jan 2013 10:19:33 -0700
Subject: [PATCH V2] ARM: tegra30: fix power up sequence for boot_secondary
In-Reply-To: <1357198291-16500-1-git-send-email-josephl@nvidia.com>
References: <1357198291-16500-1-git-send-email-josephl@nvidia.com>
Message-ID: <50E5BDA5.6040505@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2013 12:31 AM, Joseph Lo wrote:
> The power up sequence is different on the cold boot CPU and the CPU
> that resumed from the hotplug. For the cold boot CPU, it was been power
> gated as default. To power up the cold boot CPU, the power should be
> un-gated by un toggling the power gate register manually.
> 
> For the CPU that resumed from the hotplug, after un-halted the CPU. The
> flow controller will un-gate the power of the CPU. No need to manually
> control, just wait the power be resumed and continue the power up
> sequence after the CPU power is ready.
> 
> Based on the work by:
> Varun Wadekar <vwadekar@nvidia.com>

Applied to Tegra's for-3.9/soc branch.
