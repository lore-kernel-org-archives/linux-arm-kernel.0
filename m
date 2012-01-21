From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 21 Jan 2012 21:43:14 +0100
Subject: [PATCH 1/3] ARM: mx3: Remove unneeded ifdef's from mm-imx3.c
In-Reply-To: <CAOMZO5CaqMm4eNMCWP9Dyb1kC84qx+zg00FyJMw0gs93Qv94Gg@mail.gmail.com>
References: <1327084990-25402-1-git-send-email-fabio.estevam@freescale.com>
 <20120120232912.GP4066@pengutronix.de>
 <CAOMZO5CaqMm4eNMCWP9Dyb1kC84qx+zg00FyJMw0gs93Qv94Gg@mail.gmail.com>
Message-ID: <20120121204314.GA14835@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Sat, Jan 21, 2012 at 05:16:57PM -0200, Fabio Estevam wrote:
> 2012/1/20 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> 
> > and the problem was not that we can or cannot do kernels for both mx31
> > and mx35, but that we also want to do kernels for only one of them. Did
> > you try to build an mx31-only kernel after your change?
> 
> Ok, just tried it and it fails with:
> 
>   LD      .tmp_vmlinux1
> arch/arm/mach-imx/built-in.o: In function `imx35_init_early':
> mach-mx31_3ds.c:(.init.text+0x50): undefined reference to `mxc_iomux_v3_init'
> arch/arm/mach-imx/built-in.o: In function `imx35_soc_init':
> mach-mx31_3ds.c:(.init.text+0x12c): undefined reference to `mx35_revision'
> 
> I think I can solve this build issue by merging cpu-imx31.c and
> cpu-imx35.c into a single file:
> cpu-imx3.c, using the same idea as in cpu-imx5.c
... or by keeping the #ifdefs :-)

> Would you like me to do this?
I don't care much and pass the question to Sascha.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
