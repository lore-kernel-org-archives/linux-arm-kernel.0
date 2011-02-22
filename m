From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 22 Feb 2011 09:41:09 +0100
Subject: dma_declare_coherent_memory() again.
In-Reply-To: <Pine.LNX.4.64.1102211602140.26977@axis700.grange>
References: <Pine.LNX.4.64.1102211602140.26977@axis700.grange>
Message-ID: <20110222084109.GW22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 04:37:00PM +0100, Guennadi Liakhovetski wrote:
> Hi All
> 
> AFAIU, dma_declare_coherent_memory() is still present on the following 
> platforms:
> 
> arch/arm/mach-mx3/mach-pcm037.c
I had a patch for that one[1].  Russell considered it OK if I got him
correctly.  (I think it's OK from a platform's POV, maybe there are some
architecture problems?)

There were a few minor review nits, I can respin if there is general
agreement that the patch is fine.

> arch/arm/mach-mx3/mach-mx31moboard.c
> arch/arm/mach-shmobile/board-ap4evb.c
> arch/arm/mach-shmobile/board-mackerel.c (latter 2 via 
> 	drivers/media/video/sh_mobile_ceu_camera.c)
> 
> and there are no pending patches to fix them for 2.6.38, is this right? If 
> there are no realistic plans for proper memory reservation on ARM in 
> 2.6.38, shall I just submit patches to disable those calls on the above 
> platforms and hope, that the user manages to get RAM without boot-time 
> reservation? Or is a definite failure preferred?

Thanks
Uwe

[1] http://mid.gmane.org/1290505382-16110-1-git-send-email-u.kleine-koenig at pengutronix.de

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
