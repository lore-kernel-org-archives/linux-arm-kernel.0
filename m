From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 5 Nov 2010 15:00:44 +0100
Subject: [PATCH] mach-pcm037_eet: Fix section mismatch for
	eet_init_devices()
In-Reply-To: <1288630803.4156.3.camel@realization>
References: <1288630803.4156.3.camel@realization>
Message-ID: <20101105140044.GL16938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 01, 2010 at 06:00:03PM +0100, Alberto Panizzo wrote:
> This function should be marked as __init because it is used only
> in the init phase.
> 
> This fix the compiler warning:
>  LD      arch/arm/mach-mx3/built-in.o
>  WARNING: arch/arm/mach-mx3/built-in.o(.text+0x1328): Section mismatch in reference from the function eet_init_devices() to the (unknown reference) .init.rodata:(unknown)
>  The function eet_init_devices() references
>  the (unknown reference) __initconst (unknown).
>  This is often because eet_init_devices lacks a __initconst
>  annotation or the annotation of (unknown) is wrong.
> 
> Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
