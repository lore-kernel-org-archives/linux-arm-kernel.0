From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 29 Mar 2013 10:36:02 -0600
Subject: [PATCH] ARM: tegra: keep power on to SD slot on Dalmore
In-Reply-To: <1364498550-15972-1-git-send-email-swarren@wwwdotorg.org>
References: <1364498550-15972-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5155C2F2.3040009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2013 01:22 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Set "regulator-always-on" for the SD slot on Dalmore, so that SD
> cards work. This used to work, since this regulator is on by
> default, but was broken by commit "ARM: tegra: dalmore: add
> TPS65090 node", since that didn't specify always-on for this
> regulator.
> 
> In the long run, the regulators should all be hooked up to the
> SDHCI device nodes. However, we haven't done that for any of the
> Tegra boards yet, so to be consistent, this patch simply forces the
> regulator on, rather than hooking it up and making it work
> differently to other boards.

Applied to Tegra's for-3.10/dt branch.
