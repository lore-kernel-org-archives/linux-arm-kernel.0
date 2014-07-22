From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 22 Jul 2014 16:31:28 +0200
Subject: [PATCH] ARM: imx6: fix SMP compilation again
In-Reply-To: <20140722134815.GZ8537@dragon>
References: <37015543.ZyZKZyEIPW@wuerfel> <20140722085055.GX8537@dragon>
 <16557676.B1fW0k49Wz@wuerfel> <20140722134815.GZ8537@dragon>
Message-ID: <20140722143128.GC28538@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 09:48:16PM +0800, Shawn Guo wrote:
> On Tue, Jul 22, 2014 at 12:26:31PM +0200, Arnd Bergmann wrote:
> > Ah, you are right, I got the text wrong here, and I think I now understand
> > why it didn't happen earlier. Updated patch below (same patch, new
> > text).
> > 
> > 8<-------------
> > Subject: [PATCH] ARM: imx6: fix SMP compilation again
> > 
> > My earlier patch 1fc593feaf8e ("ARM: imx: build i.MX6 functions
> > only when needed") fixed a problem with building an i.MX5 kernel,
> > but now the problem has returned for the case where we allow
> > ARMv6K SMP builds in multiplatform. With CONFIG_CPU_V7 disabled,
> > but i.MX3 and SMP enabled, we get this build error:
> 
> Maybe I missed something, but I have problem to get the following three
> conditions meet in a single kernel configuration.
> 
>  a) CONFIG_CPU_V7 disabled
>  b) i.MX3 enabled
>  c) SMP enabled
> 
> When I get a) and b) in the config, I have no way to get c).  And it
> seems that the only way to get a) and c) at the same time is to enable
> MACH_REALVIEW_PB11MP, which is not part of multi-platform support.  So
> i.MX3 cannot be enabled in there.
> 
> I tried both mainline and -next tree.  I really need some help to
> reproduce the error first.
Without even looking at the patch, I think the key here is this part of
Arnd's commit log:

	for the case where we allow ARMv6K SMP builds in multiplatform
	...

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
