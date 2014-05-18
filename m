From: emilgoode@gmail.com (Emil Goode)
Date: Sun, 18 May 2014 17:38:51 +0200
Subject: [PATCH v2] ARM: imx: fix error handling
In-Reply-To: <20140517190546.GC16662@pengutronix.de>
References: <1400234045-6022-1-git-send-email-emilgoode@gmail.com>
 <5375EB13.8000200@bfs.de> <20140516111646.GC4366@lianli>
 <5375FB36.8020004@bfs.de> <20140516193139.GQ16662@pengutronix.de>
 <20140517153540.GA4309@lianli>
 <20140517190546.GC16662@pengutronix.de>
Message-ID: <20140518153851.GB4310@lianli>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I appologise for providing incomplete information in my previous message.

The involved call sites are the following:

arch/arm/mach-imx/mach-mx35_3ds.c +265

imx35_3ds_init_camera()
	imx35_alloc_mx3_camera()
		imx_alloc_mx3_camera()
	dma_declare_coherent_memory()
	platform_device_add()

arch/arm/mach-imx/mach-mx31moboard.c +477

mx31moboard_init_cam()
	imx31_alloc_mx3_camera()
		imx_alloc_mx3_camera()
	dma_declare_coherent_memory()
	platform_device_add()

arch/arm/mach-imx/mach-mx31_3ds.c +182

mx31_3ds_init_camera()
	imx31_alloc_mx3_camera()
		imx_alloc_mx3_camera()
	dma_declare_coherent_memory()
	platform_device_add()

arch/arm/mach-imx/mach-pcm037.c +413

pcm037_init_camera()
	imx31_alloc_mx3_camera()
		imx_alloc_mx3_camera()
	dma_declare_coherent_memory()
	platform_device_add()

Sorry about the mistake!

Best regards,

Emil Goode
