From: plyatov@gmail.com (Igor Plyatov)
Date: Sun, 12 Dec 2010 09:37:28 +0300
Subject: [PATCH v4] mach-at91: Support for gsia18s board added
In-Reply-To: <20101212005048.GH19897@game.jcrosoft.org>
References: <1292000411-6691-1-git-send-email-plyatov@gmail.com>
	<20101212005048.GH19897@game.jcrosoft.org>
Message-ID: <1292135848.2456.19.camel@homepc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jean-Christophe,

> On 20:00 Fri 10 Dec     , Igor Plyatov wrote:
> > The GS_IA18_S (GMS) is a carrier board from GeoSIG Ltd used with the
> > Stamp9G20 SoM from Taskit company.
> > It operate as an internet accelerometer.
> > 
> > Signed-off-by: Igor Plyatov <plyatov@gmail.com>
> > ---
> >  arch/arm/configs/gsia18s_defconfig        |  147 +++++++
> please no new defconfig
> start to merge them

I already write that it is not possible to use same defconfig for our
board and Stamp9G20, because 69 different CONFIG_xxx options required
for our machine (compared with Portux G20 and Stamp9G20) and our options
very excessive for other devices based on the Stamp9G20.
This device for the embedded, where space constraints exists for memory
and it is required to save resources as more as possible.

> your patch contain a lots of whitespace please fix it

There is no problems with whitespace. This patch checked by
scripts/checkpatch.pl twice. It seems your mailer corrupt this patch.

> > +
> > +/*
> > + * Up to date linux/arch/arm/tools/mach-types database required to support this.
> > +MACHINE_START(GSIA18S, "GS_IA18_S")
> > +*/
> > +MACHINE_START(STAMP9G20, "GS_IA18_S")
> if you do this you must use system_rev to identify the board

I can cite Christian Glindkamp:
"And for different carrier boards, system_rev does not make sense at
all."

Please, use more testimony why it is required to use system_rev here.
Yours position does not clear for me.
You can point me to the right documentation or discussion about this
requirements in the mail archives...

> > +	.boot_params	= AT91_SDRAM_BASE + 0x100,
> > +	.timer		= &at91sam926x_timer,
> > +	.map_io		= gsia18s_map_io,
> > +	.init_irq	= init_irq,
> > +	.init_machine	= gsia18s_board_init,
> > +MACHINE_END
> Best Regards,
> J.

Best regards!
--
Igor Plyatov
