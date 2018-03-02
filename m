From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 2 Mar 2018 12:11:43 +0000
Subject: [PATCH 0/4] drm/pl111: RealView and Versatile Express
In-Reply-To: <20180302090948.6399-1-linus.walleij@linaro.org>
References: <20180302090948.6399-1-linus.walleij@linaro.org>
Message-ID: <6b215e16-5245-7550-f1cb-a0f41d4a3178@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 02/03/18 09:09, Linus Walleij wrote:
> This is the base for finally getting RealView and Versatile
> Express supported in the PL111 DRM driver.
> 
> We have then moved all the way up from the first ARM
> Integrator versions to the last Versatile Express reference
> designs using PL111.
> 
> After this, forked hardware such as Nomadik and SPEAr
> remains to be moved over.
> 
> Some infrastructure for adjusting depth (ARGB5551) etc
> on the Integrator and some bridge fixups are still needed
> but this is the core of the support for these platforms
> and the rest can be done on top before switching over.
> 
> Also the Versatile Express CLCD on the motherboard has
> a dedicated video memory, and cannot use CMA (ha! complex!)
> and I will need to figure out a way to work around that.
> The CLCDs synthesized on the core tiles for CA9 work
> fine with this though.

Out of curiosity, what's the issue with declaring the VRAM as a CMA 
region? That's certainly worked for stuff like local RAM on FPGA tiles 
in the past, and I can't think offhand of any way in which VExpress is 
wildly different (but I am of course open to being wrong...)

Robin.

> Linus Walleij (4):
>    drm/pl111: Make the default BPP a per-variant variable
>    drm/pl111: Use max memory bandwidth for resolution
>    drm/pl111: Handle the RealView variant separately
>    drm/pl111: Support the Versatile Express
> 
>   drivers/gpu/drm/pl111/Makefile          |   1 +
>   drivers/gpu/drm/pl111/pl111_display.c   |  36 +++++++++++
>   drivers/gpu/drm/pl111/pl111_drm.h       |   6 +-
>   drivers/gpu/drm/pl111/pl111_drv.c       |  10 ++-
>   drivers/gpu/drm/pl111/pl111_versatile.c |  80 +++++++++++++++++++++++-
>   drivers/gpu/drm/pl111/pl111_vexpress.c  | 106 ++++++++++++++++++++++++++++++++
>   drivers/gpu/drm/pl111/pl111_vexpress.h  |  22 +++++++
>   7 files changed, 258 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/gpu/drm/pl111/pl111_vexpress.c
>   create mode 100644 drivers/gpu/drm/pl111/pl111_vexpress.h
> 
