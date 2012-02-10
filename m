From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 09 Feb 2012 20:58:23 -0800
Subject: [PATCH 0/3] pinctrl: move the core per-device handlers to core
In-Reply-To: <1328814050-22715-1-git-send-email-linus.walleij@linaro.org>
References: <1328814050-22715-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <4F34A3EF.3070207@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2012 11:00 AM, Linus Walleij wrote:
> After discussing with some people involved with pin control, we agreed
> that it will just cause trouble to have separate handles for pin muxing
> and pin configuration in callers - they will definately want to set all
> pin aspects regarding muxing and other configuration with one single
> call.
> 
> These three patches take the first step in this transformation by moving
> the per-device handles over to core code, and renaming all related
> functions with the pinctrl_* prefix.

The series,

Acked-by: Stephen Warren <swarren@nvidia.com>

Note that this series will cause some compile breakage in the series I
previously posted to add a pinctrl-tegra driver and convert mach-tegra
to use it. The following patches in that series should still be OK:

pinctrl: add a driver for NVIDIA Tegra
ARM: tegra: Select PINCTRL Kconfig variables

... so you can still go ahead and apply those, but the following will be
broken:

ARM: tegra: Switch to new pinctrl driver
ARM: tegra: Remove pre-pinctrl pinmux driver

also the separately posted:

ARM: tegra: Add pinmux board file for Cardhu

I'll probably hold off reposting those last 3; with any luck they'll be
eclipsed by my implementing full DT binding support in the near future,
given our consensus on that topic following discussion at Linaro Connect.

-- 
nvpublic
