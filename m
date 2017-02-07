From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 7 Feb 2017 13:37:07 +0100
Subject: [PATCH v2 7/7] drm/rockchip: Call drm_gem_object_release() to
 destroy GEM base
In-Reply-To: <1486456773-19233-1-git-send-email-mark.yao@rock-chips.com>
References: <1486456542-18675-1-git-send-email-mark.yao@rock-chips.com>
 <1486456773-19233-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <20170207123707.GC18315@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 04:39:33PM +0800, Mark Yao wrote:
> From: Tomasz Figa <tfiga@chromium.org>
> 
> When converting the driver to use shmem-backed GEMs for IOMMU-enabled
> systems, we forgot to add calls to drm_gem_object_release(), which gave
> us a quite nice memory leak. This patch adds the missing calls.
> 
> Fixes: f11d5f0 ("FROMLIST: drm/rockchip: Do not use DMA mapping API if
> attached to IOMMU domain")
> 
> TEST=while true; do backlight_dbus_tool --set --percent=0 && sleep 8 &&
>  backlight_dbus_tool --set --percent=100 && sleep 3 ; done

Ugh... please clean up your commit messages before posting to the
mailing list. FROMLIST: patches clearly aren't what will be merged
upstream and the SHA1 isn't going to match, so nobody but you will
find this anywhere.

> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> Reviewed-on: https://chromium-review.googlesource.com/385456

This is also present in some of the patches you posted, but it's not
typical for these to be included in upstream patches because usually
by the time patches from some gerrit make it to upstream, upstream
can have diverged significantly enough for the review to no longer
apply.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/de71c776/attachment.sig>
