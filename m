From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 5 Oct 2013 16:38:33 -0700
Subject: [PATCH stable] ARM: tegra: unify Tegra's Kconfig a bit more
In-Reply-To: <1380917411-25869-1-git-send-email-swarren@wwwdotorg.org>
References: <1380917411-25869-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131005233833.GA18223@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 04, 2013 at 02:10:11PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Move all common select clauses from ARCH_TEGRA_*_SOC to ARCH_TEGRA to
> eliminate duplication. The USB-related selects all should have been
> common too, but were missing from Tegra114 previously. Move these to
> ARCH_TEGRA too. The latter fixes a build break when only Tegra114
> support was enabled, but not Tegra20 or Tegra30 support.
> 
> This is 20984c44b5a08620778ea14fa5807489170fd5ca in v3.12-rc1.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> Reported-by: Paul Walmsley <pwalmsley@nvidia.com>
> [auto-builders for 3.11.x are failing due to this]

What autobuilders?  I haven't heard of this before.

> Cc: stable # v3.11
> ---
>  arch/arm/mach-tegra/Kconfig | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)

This fails to apply to the 3.11-stable tree, if you want it there, can
you provide a version that actually does apply, and that you have tested
to work properly?

thanks,

greg k-h
