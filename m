From: eric@anholt.net (Eric Anholt)
Date: Thu, 03 May 2018 14:20:42 -0700
Subject: [PATCH] arm64: defconfig: Increase CMA size for VC4
In-Reply-To: <1525296700-3588-1-git-send-email-stefan.wahren@i2se.com>
References: <1525296700-3588-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87bmdwo2qd.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

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

If there was a way to check how big the CMA pool is, then we could
probably have V3D disable itself when the pool was too small.  It's not
like V3D rendering is going to actually *work* with just a 32mb pool to
play in.

That said, I'd also be fine with this patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180503/04dd6dce/attachment.sig>
