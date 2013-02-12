From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Feb 2013 10:47:33 -0700
Subject: [PATCH] ARM: tegra: remove clock-frequency properties from serial
 nodes
In-Reply-To: <1360691025-8393-1-git-send-email-swarren@wwwdotorg.org>
References: <1360691025-8393-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <511A8035.6080808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2013 10:43 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Currently, the serial nodes define both a clock-frequency and a clocks
> property. We should not provide both, since they might conflict.
> 
> In practice, this also causes problems since the of_serial driver uses
> the clock-frequency property in preference to the clocks property, and
> hence doesn't clk_prepare_enable() the clock, which may then leave it
> with no known users, and hence the common clock framework will disable
> it, thus breaking the port, which is usually the console.

I've applied this to Tegra's for-3.9/soc-ccf-fixes branch, although I'll
hold off on pushing it out a little while in case anyone has comments on
it. That said, I hope to include it in an arm-soc pull request tomorrow
at the latest.
