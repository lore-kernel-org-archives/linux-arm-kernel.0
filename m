From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 30 Mar 2013 14:16:45 +0000
Subject: [PATCH 2/2] ARM: tegra: convert to multi-platform
In-Reply-To: <1364602790-10759-2-git-send-email-swarren@wwwdotorg.org>
References: <1364602790-10759-1-git-send-email-swarren@wwwdotorg.org>
 <1364602790-10759-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201303301416.45525.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 30 March 2013, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This allows Tegra be included in a kernel build that supports multiple
> SoCs at once, which is useful for distro kernels.
> 
> This change:
> * Moves Tegra's Kconfig into its own directory, as seems typical for
>   multi-platform conversions.
> * Stops selecting some ARM errata that are incompatible with multi-
>   platform. This requires that you use a bootloader that enables the
>   workaround!
> * Deletes some headers and Makefile.boot that aren't needed now that we
>   support multi-platform.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Ok, very nice.

I already commented on patch 1 of the series, which I hope we can
replace with something better.

Another comment is that the EHCI driver is broken for Tegra if enabled
in combination with one of a few other platforms. Manjunath has an
experimental patch for this, but there are still problems with that
patch. I'll forward a private copy of the last version we had, and
you can try to get it working from there.

	Arnd
