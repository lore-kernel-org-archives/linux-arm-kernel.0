From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 23 Jun 2014 14:04:52 +0300
Subject: [PATCH v7 1/2] video: ARM CLCD: Add DT support
In-Reply-To: <1403018494-10264-1-git-send-email-pawel.moll@arm.com>
References: <1403018494-10264-1-git-send-email-pawel.moll@arm.com>
Message-ID: <53A809D4.90800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 17/06/14 18:21, Pawel Moll wrote:
> This patch adds basic DT bindings for the PL11x CLCD cells
> and make their fbdev driver use them.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
> Changes since v6:
> - replaced in-node device-timing subnode with the standard
>   video interface bindings (as in: ports & endpoints); only
>   "panel-dpi" compatible panels are supported in the driver
> 
> Changes since v5:
> - realised that dma_alloc_writecombine() is a arm-specific function;
>   replaced with generic dma_alloc_coherent()/dma_mmap_writecombine()
> 
> Changes since v4:
> - simplified the pads description property and made it optional
> 
> Changes since v3:
> - changed wording and order of interrupt-names and interrupts
>   properties documentation
> - changed wording of arm,pl11x,framebuffer-base property
>   documentation
> - cleaned up binding documentation indentation
> 
> Changes since v2:
> - replaced video-ram phandle with arm,pl11x,framebuffer-base
> - replaced panel-* properties with arm,pl11x,panel-data-pads
> - replaced max-framebuffer-size with max-memory-bandwidth
> - modified clcdfb_of_init_tft_panel() to use the pads
>   data and take differences between PL110 and PL110 into
>   account
> 
> Changes since v1:
> - minor code cleanups as suggested by Sylwester Nawrocki
> 
>  .../devicetree/bindings/video/arm,pl11x.txt        | 102 ++++++++
>  drivers/video/fbdev/Kconfig                        |   1 +
>  drivers/video/fbdev/amba-clcd.c                    | 268 +++++++++++++++++++++
>  3 files changed, 371 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/arm,pl11x.txt

I can queue this to fbdev tree, but how do you want to handle the second
patch? I think these two patches are independent, so the second patch
could go via arm-soc tree (or whichever is the normal route for those
.dts file changes). I'd prefer that option.

If these need to go together, I need acks for the second patch.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140623/ddb5de4e/attachment.sig>
