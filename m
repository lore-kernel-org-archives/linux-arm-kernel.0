From: olof@lixom.net (Olof Johansson)
Date: Mon, 25 Nov 2013 14:06:34 -0800
Subject: [PATCH] ARM: tegra: Provide dummy powergate implementation
In-Reply-To: <1385405387-27265-1-git-send-email-swarren@wwwdotorg.org>
References: <1385405387-27265-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131125220634.GA18001@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 11:49:47AM -0700, Stephen Warren wrote:
> From: Thierry Reding <thierry.reding@gmail.com>
> 
> In order to support increased build test coverage for drivers, implement
> dummies for the powergate implementation. This will allow the drivers to
> be built without requiring support for Tegra to be selected.
> 
> This patch solves the following build errors, which can be triggered in
> v3.13-rc1 by selecting DRM_TEGRA without ARCH_TEGRA:
> 
> drivers/built-in.o: In function `gr3d_remove':
> drivers/gpu/drm/tegra/gr3d.c:321: undefined reference to `tegra_powergate_power_off'
> drivers/gpu/drm/tegra/gr3d.c:325: undefined reference to `tegra_powergate_power_off'
> drivers/built-in.o: In function `gr3d_probe':
> drivers/gpu/drm/tegra/gr3d.c:266: undefined reference to `tegra_powergate_sequence_power_up'
> drivers/gpu/drm/tegra/gr3d.c:273: undefined reference to `tegra_powergate_sequence_power_up'
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> [swarren, updated commit description]
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This is a fix for 3.13.

Thanks, applied.

-Olof
