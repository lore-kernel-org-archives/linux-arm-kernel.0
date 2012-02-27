From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 Feb 2012 17:41:43 +0800
Subject: [PATCH] ARM: mach-imx: mx3: Fix section mismatch in
 imx3_init_l2x0()
In-Reply-To: <20120227093937.GC31207@S2101-09.ap.freescale.net>
References: <1330273624-5757-1-git-send-email-festevam@gmail.com>
 <20120227093937.GC31207@S2101-09.ap.freescale.net>
Message-ID: <20120227094141.GD31207@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 05:39:39PM +0800, Shawn Guo wrote:
> On Sun, Feb 26, 2012 at 01:27:04PM -0300, Fabio Estevam wrote:
> > Fix the following section mismatch:
> > 
> > WARNING: vmlinux.o(.text+0x11be8): Section mismatch in reference from the function imx3_init_l2x0() to the function .init.text:l2x0_init()
> > The function imx3_init_l2x0() references
> > the function __init l2x0_init().
> > This is often because imx3_init_l2x0 lacks a __init 
> > annotation or the annotation of l2x0_init is wrong.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> I'm seeing this warning with imx_v6_v7_defconfig build too, and would
> like to send a fix for -rc right away.
> 
Great, Sascha is taking care of it.

-- 
Regards,
Shawn
