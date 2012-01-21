From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 21 Jan 2012 17:16:57 -0200
Subject: [PATCH 1/3] ARM: mx3: Remove unneeded ifdef's from mm-imx3.c
In-Reply-To: <20120120232912.GP4066@pengutronix.de>
References: <1327084990-25402-1-git-send-email-fabio.estevam@freescale.com>
 <20120120232912.GP4066@pengutronix.de>
Message-ID: <CAOMZO5CaqMm4eNMCWP9Dyb1kC84qx+zg00FyJMw0gs93Qv94Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2012/1/20 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:

> and the problem was not that we can or cannot do kernels for both mx31
> and mx35, but that we also want to do kernels for only one of them. Did
> you try to build an mx31-only kernel after your change?

Ok, just tried it and it fails with:

  LD      .tmp_vmlinux1
arch/arm/mach-imx/built-in.o: In function `imx35_init_early':
mach-mx31_3ds.c:(.init.text+0x50): undefined reference to `mxc_iomux_v3_init'
arch/arm/mach-imx/built-in.o: In function `imx35_soc_init':
mach-mx31_3ds.c:(.init.text+0x12c): undefined reference to `mx35_revision'

I think I can solve this build issue by merging cpu-imx31.c and
cpu-imx35.c into a single file:
cpu-imx3.c, using the same idea as in cpu-imx5.c

Would you like me to do this?

Regards,

Fabio Estevam
