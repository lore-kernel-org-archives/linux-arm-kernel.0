From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 10 Dec 2014 13:21:07 +0100
Subject: [PATCH RFC 04/15] drm/dsi: Do not add DSI devices for the child
 nodes with input-port property
In-Reply-To: <1418200648-32656-5-git-send-email-Ying.Liu@freescale.com>
References: <1418200648-32656-1-git-send-email-Ying.Liu@freescale.com>
 <1418200648-32656-5-git-send-email-Ying.Liu@freescale.com>
Message-ID: <20141210122105.GC23558@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 04:37:17PM +0800, Liu Ying wrote:
> The MIPI DSI bus driver would try to add a DSI device for a host's every
> child node which contains the reg property.  Unfortunately, the existing
> i.MX6Q/SDL MIPI DSI host device tree node's child nodes contain the reg

There aren't any existing nodes for the DSI host on i.MX. This patch
series adds support for them.

> property, but the child nodes are ports pointing to dedicated CRTCs.
> So, this patch phases out the child nodes with input-port property before
> adding DSI devices for them and updates the MIPI DSI bus OF binding
> documentation.
> 
> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> ---
>  Documentation/devicetree/bindings/mipi/dsi/mipi-dsi-bus.txt | 4 ++++
>  drivers/gpu/drm/drm_mipi_dsi.c                              | 5 +++--
>  2 files changed, 7 insertions(+), 2 deletions(-)

Sorry, but NAK. There's no need for this special-case. I'll go into more
detail in response to patch 09/15.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141210/6e6f1051/attachment.sig>
