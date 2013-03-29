From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 29 Mar 2013 11:16:12 +0530
Subject: [PATCH] ARM: tegra: keep power on to SD slot on Dalmore
In-Reply-To: <1364498550-15972-1-git-send-email-swarren@wwwdotorg.org>
References: <1364498550-15972-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <51552AA4.1030607@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 March 2013 12:52 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> Set "regulator-always-on" for the SD slot on Dalmore, so that SD cards
> work. This used to work, since this regulator is on by default, but was
> broken by commit "ARM: tegra: dalmore: add TPS65090 node", since that
> didn't specify always-on for this regulator.
>
> In the long run, the regulators should all be hooked up to the SDHCI
> device nodes. However, we haven't done that for any of the Tegra boards
> yet, so to be consistent, this patch simply forces the regulator on,
> rather than hooking it up and making it work differently to other boards.
>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Reported-by: Rhyland Klein <rklein@nvidia.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>

This means we should keep sd slot rails always ON when we populate the 
power tree for any Tegra board?
