From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 15 May 2013 17:02:33 -0600
Subject: [PATCH 5/6] clk: tegra114: implement wait_for_reset and
 disable_clock for tegra_cpu_car_ops
In-Reply-To: <1368613644-11863-6-git-send-email-josephl@nvidia.com>
References: <1368613644-11863-1-git-send-email-josephl@nvidia.com>
 <1368613644-11863-6-git-send-email-josephl@nvidia.com>
Message-ID: <51941409.3030909@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2013 04:27 AM, Joseph Lo wrote:
> The conventional CPU hotplug sequence on the other Tegra chips, we will also
> clock gate the CPU in tegra_cpu_kill() after the CPU was power gated. For
> Tegra114, the flow controller will clock gate the CPU after the power down
> sequence. But we still need to implement a empty function for disable_clock
> to avoid kernel warning message.

I assume I need to apply this patch in the Tegra tree along with all the
other patches in this series? i.e. Mike can't apply it on its own to the
clk tree?

If so, I'll wait for an ack from Mike.
