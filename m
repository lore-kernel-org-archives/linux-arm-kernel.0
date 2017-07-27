From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 27 Jul 2017 18:45:41 +0200
Subject: [PATCH] gpu: host1x: Free the IOMMU domain when there is no
 device to attach
In-Reply-To: <20170710193305.5987-1-contact@paulk.fr>
References: <20170710193305.5987-1-contact@paulk.fr>
Message-ID: <20170727164541.GA25081@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 10, 2017 at 09:33:05PM +0200, Paul Kocialkowski wrote:
> When there is no device to attach to the IOMMU domain, as may be the
> case when the device-tree does not contain the proper iommu node, it is
> best to keep going without IOMMU support rather than failing.
> This allows the driver to probe and function instead of taking down
> all of the tegra drm driver, leading to missing display support.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/gpu/host1x/dev.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Applied to drm-misc-fixes, thanks.

Oh, just noticed now that this didn't actually go to the DRM mailing
list (dri-devel at lists.freedesktop.org). Might be a good idea to do that
next time to get more visibility.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170727/d5c4ef09/attachment.sig>
