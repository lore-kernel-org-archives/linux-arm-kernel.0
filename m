From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 27 Nov 2018 00:37:07 +0100
Subject: [PATCH 2/9] iommu: rockchip: make it explicitly non-modular
In-Reply-To: <1543271498-28966-3-git-send-email-paul.gortmaker@windriver.com>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
 <1543271498-28966-3-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <3696101.6o5idU3W3V@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 26. November 2018, 23:31:31 CET schrieb Paul Gortmaker:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/iommu/Kconfig:config ROCKCHIP_IOMMU
> drivers/iommu/Kconfig:  bool "Rockchip IOMMU Support"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> The bind/unbind/remove was already explicitly disabled in commit
> 98b72b94def9 ("iommu/rockchip: Prohibit unbind and remove").
> 
> Lets remove the remaining traces of  modular infrastructure, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Since module_init was not in use by this code, the init ordering
> remains unchanged with this commit.
> 
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Simon Xue <xxm@rock-chips.com>
> Cc: Daniel Kurtz <djkurtz@chromium.org>
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Cc: iommu at lists.linux-foundation.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-rockchip at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>
