From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 10 Sep 2018 11:07:36 +0200
Subject: [PATCH] drm/rockchip: Allow driver to be shutdown on reboot/kexec
In-Reply-To: <20180805124807.18169-1-marc.zyngier@arm.com>
References: <20180805124807.18169-1-marc.zyngier@arm.com>
Message-ID: <384166528.3nXvZOV8Bt@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 5. August 2018, 14:48:07 CEST schrieb Marc Zyngier:
> Leaving the DRM driver enabled on reboot or kexec has the annoying
> effect of leaving the display generating transactions whilst the
> IOMMU has been shut down.
> 
> In turn, the IOMMU driver (which shares its interrupt line with
> the VOP) starts warning either on shutdown or when entering the
> secondary kernel in the kexec case (nothing is expected on that
> front).
> 
> A cheap way of ensuring that things are nicely shut down is to
> register a shutdown callback in the platform driver.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

applied to drm-misc-next
with Vicentes Tested-tag and also a Cc: stable tag added.

sorry for the holdup
Heiko
