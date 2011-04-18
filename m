From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 18 Apr 2011 10:06:37 +0200
Subject: [PATCH] V4L: mx3_camera: select VIDEOBUF2_DMA_CONTIG instead of
	VIDEOBUF_DMA_CONTIG
In-Reply-To: <1302166243-650-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1302166243-650-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110418080637.GA31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

On Thu, Apr 07, 2011 at 10:50:43AM +0200, Uwe Kleine-K?nig wrote:
> Since commit
> 
> 	379fa5d ([media] V4L: mx3_camera: convert to videobuf2)
> 
> mx3_camera uses videobuf2, but that commit didn't upgrade the select
> resulting in the following build failure:
> 
> 	drivers/built-in.o: In function `mx3_camera_init_videobuf':
> 	clkdev.c:(.text+0x86580): undefined reference to `vb2_dma_contig_memops'
> 	drivers/built-in.o: In function `mx3_camera_probe':
> 	clkdev.c:(.devinit.text+0x3548): undefined reference to `vb2_dma_contig_init_ctx'
> 	clkdev.c:(.devinit.text+0x3578): undefined reference to `vb2_dma_contig_cleanup_ctx'
> 	drivers/built-in.o: In function `mx3_camera_remove':
> 	clkdev.c:(.devexit.text+0x674): undefined reference to `vb2_dma_contig_cleanup_ctx'
> 	make[2]: *** [.tmp_vmlinux1] Error 1
> 	make[1]: *** [sub-make] Error 2
> 	make: *** [all] Error 2
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
I guess the only problem with this is -ENOTIME on your side?

> does someone has a hint how to fix gcc not to believe the undefined
> references to be in clkdev.c?
I got a hint that might be related to ccache. Didn't look into it yet,
though.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
