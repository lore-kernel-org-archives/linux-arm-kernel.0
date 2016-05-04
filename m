From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 4 May 2016 20:34:17 +0200
Subject: [PATCH] drm: sun4i: print DMA address correctly
In-Reply-To: <1462289020-774976-1-git-send-email-arnd@arndb.de>
References: <1462289020-774976-1-git-send-email-arnd@arndb.de>
Message-ID: <20160504183417.GF17159@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2016 at 05:23:28PM +0200, Arnd Bergmann wrote:
> The newly added sun4i drm driver prints a dma address using the %x
> format string, which cannot work when dma_addr_t is 64 bit,
> and gcc warns about this configuration:
> 
> drm/sun4i/sun4i_backend.c: In function 'sun4i_backend_update_layer_buffer':
> drm/sun4i/sun4i_backend.c:193:84: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'dma_addr_t {aka long long unsigned int}' [-Werror=format=]
>   DRM_DEBUG_DRIVER("Using GEM @ 0x%x\n", gem->paddr);
> drm/sun4i/sun4i_backend.c:201:84: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'dma_addr_t {aka long long unsigned int}' [-Werror=format=]
>   DRM_DEBUG_DRIVER("Setting buffer address to 0x%x\n", paddr);
> 
> This changes the code to use the explicit %pad format string, which
> always prints the right length.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160504/459377c2/attachment.sig>
