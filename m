From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 2 Jan 2013 14:15:43 +0200
Subject: [PATCH] ARM: tegra30: fix power up sequence for boot_secondary
In-Reply-To: <1355970603-28531-1-git-send-email-josephl@nvidia.com>
References: <1355970603-28531-1-git-send-email-josephl@nvidia.com>
Message-ID: <20130102121543.GS19766@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 03:30:03AM +0100, Joseph Lo wrote:
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
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
