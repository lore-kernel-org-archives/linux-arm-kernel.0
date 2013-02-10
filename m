From: olof@lixom.net (Olof Johansson)
Date: Sat, 9 Feb 2013 17:52:35 -0800
Subject: [PATCH 1/2] ARM: tegra: enable ARCH_REQUIRE_GPIOLIB for Tegra114
In-Reply-To: <1360273404-32397-1-git-send-email-swarren@wwwdotorg.org>
References: <1360273404-32397-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130210015235.GA25302@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 07, 2013 at 02:43:23PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> CONFIG_ARCH_TEGRA_114_SOC doesn't currently enable gpiolib, which causes
> numerous build problems building a Tegra kernel with only Tegra114
> enabled, and not Tegra20 or Tegra30. Enable ARCH_REQUIRE_GPIOLIB to
> solve this. However, all Tegra will use gpiolib, so select this option
> from ARCH_TEGRA rather than each individual ARCH_TEGRA_*_SOC, to
> prevent this problem for any future chips.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Olof, Arnd, These two patches can be applied on top of Tegra's previous
> tegra-for-3.9-soc-t114 branch.
> 
> I think this (coupled with Hiroshi's "ARM: tegra: Fix build error w/
> ARCH_TEGRA_114_SOC w/o ARCH_TEGRA_3x_SOC" is it for build failure fixes,
> although I'm queueing up a number of clock driver patches for which I'll
> send a pull request in the next few days.

Thanks, applied both to the tegra/t114 branch (together with the above
mentioned fix).


-Olof
