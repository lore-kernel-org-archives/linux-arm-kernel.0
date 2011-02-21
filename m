From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 21 Feb 2011 16:37:00 +0100 (CET)
Subject: dma_declare_coherent_memory() again.
Message-ID: <Pine.LNX.4.64.1102211602140.26977@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All

AFAIU, dma_declare_coherent_memory() is still present on the following 
platforms:

arch/arm/mach-mx3/mach-pcm037.c
arch/arm/mach-mx3/mach-mx31moboard.c
arch/arm/mach-shmobile/board-ap4evb.c
arch/arm/mach-shmobile/board-mackerel.c (latter 2 via 
	drivers/media/video/sh_mobile_ceu_camera.c)

and there are no pending patches to fix them for 2.6.38, is this right? If 
there are no realistic plans for proper memory reservation on ARM in 
2.6.38, shall I just submit patches to disable those calls on the above 
platforms and hope, that the user manages to get RAM without boot-time 
reservation? Or is a definite failure preferred?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
