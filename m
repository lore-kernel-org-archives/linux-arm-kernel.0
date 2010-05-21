From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 21 May 2010 09:19:34 +0200
Subject: [PATCH 1/3] mx2_camera: Add soc_camera support for i.MX25/i.MX27
In-Reply-To: <a029bab8fcb3273df4a1d98f779f110b127742bd.1273150585.git.baruch@tkos.co.il>
References: <cover.1273150585.git.baruch@tkos.co.il>
	<a029bab8fcb3273df4a1d98f779f110b127742bd.1273150585.git.baruch@tkos.co.il>
Message-ID: <20100521071934.GC17272@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 06, 2010 at 04:09:39PM +0300, Baruch Siach wrote:
> This is the soc_camera support developed by Sascha Hauer for the i.MX27.  Alan
> Carvalho de Assis modified the original driver to get it working on more recent
> kernels. I modified it further to add support for i.MX25. This driver has only
> been tested on the i.MX25 platform.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm/plat-mxc/include/mach/memory.h  |    4 +-
>  arch/arm/plat-mxc/include/mach/mx2_cam.h |   41 +
>  drivers/media/video/Kconfig              |   14 +
>  drivers/media/video/Makefile             |    1 +
>  drivers/media/video/mx2_camera.c         | 1396 ++++++++++++++++++++++++++++++
>  5 files changed, 1454 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/include/mach/mx2_cam.h
>  create mode 100644 drivers/media/video/mx2_camera.c
> 

On i.MX27 in DMA mode you pass the kernel virtual address to the DMA
engine. Should be a physical address, so please amend the following:
