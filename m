From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 12 Dec 2017 17:58:24 +0100
Subject: [PATCH 04/41] drm/rockchip: Respect page offset for PRIME mmap
 calls
In-Reply-To: <20170310043305.17216-5-seanpaul@chromium.org>
References: <20170310043305.17216-1-seanpaul@chromium.org>
 <20170310043305.17216-5-seanpaul@chromium.org>
Message-ID: <2101866.79D84rxXxt@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Donnerstag, 9. M?rz 2017, 23:32:19 CET schrieb Sean Paul:
> From: ?rjan Eide <orjan.eide@arm.com>
> 
> When mapping external DMA-bufs through the PRIME mmap call, we might be
> given an offset which has to be respected. However for the internal DRM
> GEM mmap path, we have to ignore the fake mmap offset used to identify
> the buffer only. Currently the code always zeroes out vma->vm_pgoff,
> which breaks the former.
> 
> This patch fixes the problem by moving the vm_pgoff assignment to a
> function that is used only for GEM mmap path, so that the PRIME path
> retains the original offset.
> 
> BUG=chrome-os-partner:56615
> TEST=graphics_GLBench

Unneeded chromeos-cruft.

> Cc: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: ?rjan Eide <orjan.eide@arm.com>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>

With the same testas patch 3  (rk3328 + lima)
Tested-by: Heiko Stuebner <heiko@sntech.de>
