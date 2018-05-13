From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 13 May 2018 09:58:49 -0700
Subject: [PATCH] arm64: defconfig: Increase CMA size for VC4
In-Reply-To: <1525296700-3588-1-git-send-email-stefan.wahren@i2se.com>
References: <1525296700-3588-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <968ffb1f-8a3a-00d6-996d-35d5db30d25b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 05/02/18 ? 14:31, Stefan Wahren a ?crit?:
> The VC4 needs more memory than the default setting (16 MB):
> 
>   vc4-drm soc:gpu: swiotlb: coherent allocation failed, size=16777216
>   [drm:vc4_bo_create [vc4]] *ERROR* Failed to allocate from CMA:
>   vc4_v3d 3fc00000.v3d: Failed to allocate memory for tile binning: -12.
>     You may need to enable CMA or give it more memory.
>   vc4-drm soc:gpu: failed to bind 3fc00000.v3d (ops vc4_v3d_ops [vc4]): -12
>   vc4-drm soc:gpu: master bind failed: -12
>   vc4-drm: probe of soc:gpu failed with error -12
> 
> So increase the value to 32 MB and fix this issue.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied to defconfig-arm64/next, thanks!
-- 
Florian
