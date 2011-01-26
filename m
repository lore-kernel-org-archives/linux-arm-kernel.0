From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 26 Jan 2011 09:46:13 +0100
Subject: [PATCH] ARM: OMAP2: use early init hook
In-Reply-To: <20110123171344.GH30094@n2100.arm.linux.org.uk>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
Message-ID: <20110126084613.GD1147@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Sun, Jan 23, 2011 at 05:13:44PM +0000, Russell King - ARM Linux wrote:
> Move non-mapping and non-irq initialization code out of .map_io and
> .init_irq respectively into the new init_early hook.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> I think I've updated this patch correctly for the new platforms merged
> into mainline.
> 
> Please ensure that new platforms merged after this patch also use the
> new structure, and note that the initializers should be listed in the
> following order:
> 
> 	.fixup
> 	.reserve
> 	.map_io
> 	.init_early
> 	.init_irq
> 	.timer
> 	.init_machine
Will you care for imx (mach-{mx*,imx}), too, or should I fix them up?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
