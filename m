From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Fri, 10 Dec 2010 11:59:19 +0100
Subject: [RESEND] [PATCH 0/2] OMAP1: amsdelta: reserve memory for
	videobuf_contig
In-Reply-To: <201012051929.07220.jkrzyszt@tis.icnet.pl>
References: <201012051929.07220.jkrzyszt@tis.icnet.pl>
Message-ID: <201012101159.21845.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since there were no request for changes, I'm resending the set, 
this time Cc linux-arm-kernel.

Sunday 05 December 2010 19:29:05 Janusz Krzysztofik wrote:
> Latest developements seem to allow for reserving a block of memory on boot
> to be used as a device dedicated dma coherent memory. This may be required
> for videobuf_config based video drivers avoid problems with allocating dma
> coherent memory after system memory gets fragmented.
>
> This set extends the OMAP1 camera resource initialization code with a
> function that can be used for reserving a block of memory early, then
> declared as the camera device dedicated dma coherent memory.
>
> An example use case is provided for Amstrad Delta camera.
>
>  arch/arm/mach-omap1/board-ams-delta.c     |   12 +++++++++-
>  arch/arm/mach-omap1/devices.c             |   36 ++++++++++++++++++++++++++++++ 
>  arch/arm/mach-omap1/include/mach/camera.h |    1
>  3 files changed, 48 insertions(+), 1 deletion(-)
>
>
> Thanks,
> Janusz
