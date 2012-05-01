From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 01 May 2012 12:11:55 -0600
Subject: [PATCH] ARM: move read_{boot,
 persistent}_clock to the architecture level
In-Reply-To: <1335617145-24649-1-git-send-email-marc.zyngier@arm.com>
References: <1335617145-24649-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <4FA0276B.9090303@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2012 06:45 AM, Marc Zyngier wrote:
> At the moment, read_persistent_clock is implemented at the
> platform level, which makes it impossible to compile these
> platforms in a single kernel.
> 
> Implement these two functions at the architecture level, and
> provide a thin registration interface for both read_boot_clock
> and read_persistent_clock. The two affected platforms (OMAP and
> Tegra) are converted at the same time.
> 
> Compile tested only.
> 
> Reported-by: Jeff Ohlstein <johlstei@codeaurora.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Tested-by: Stephen Warren <swarren@wwwdotorg.org>

I'm not sure exactly how to fully exercise this, but Tegra still boots
without issue or obvious error messages with this patch applied.
