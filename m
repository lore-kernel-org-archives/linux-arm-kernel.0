From: schindele@nentec.de (Juergen Schindele)
Date: Fri, 2 Jul 2010 09:45:41 +0200
Subject: [PATCH 27/33] Removing dead IDE_PXA_CF
In-Reply-To: <AANLkTikXk-NPcDlf0lCSbf8HYHfoZoWh-7bnQar80UMC@mail.gmail.com>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<a332e637ee15cb15f7099f5dfc19a384b2bf772b.1277911346.git.siccegge@cs.fau.de>
	<AANLkTikXk-NPcDlf0lCSbf8HYHfoZoWh-7bnQar80UMC@mail.gmail.com>
Message-ID: <201007020945.42597.schindele@nentec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 1. Juli 2010 schrieb Eric Miao:
> On Thu, Jul 1, 2010 at 12:02 AM, Christoph Egger <siccegge@cs.fau.de> wrote:
> > IDE_PXA_CF doesn't exist in Kconfig, therefore removing all references
> > for it from the source code.
> >
> > Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> 
> Acked-by: Eric Miao <eric.y.miao@gmail.com>
> 
> Include Jurgen though, in case he has any idea.
> 
> > ---
> > ?arch/arm/mach-pxa/trizeps4.c | ? ?6 +-----
> > ?1 files changed, 1 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
> > index 6968911..0acff17 100644
> > --- a/arch/arm/mach-pxa/trizeps4.c
> > +++ b/arch/arm/mach-pxa/trizeps4.c
> > @@ -530,13 +530,9 @@ static void __init trizeps4_init(void)
> > ? ? ? ?i2c_register_board_info(0, trizeps4_i2c_devices,
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?ARRAY_SIZE(trizeps4_i2c_devices));
> >
Its OK for me to remove this because i can use pata_platform
instead and a rework of trizeps4/5 is planned.  
Recently it was very hard for me to follow all changes.
> > -#ifdef CONFIG_IDE_PXA_CF
> > - ? ? ? /* if boot direct from compact flash dont disable power */
> > - ? ? ? trizeps_conxs_bcr = 0x0009;
> > -#else
> > ? ? ? ?/* this is the reset value */
> > ? ? ? ?trizeps_conxs_bcr = 0x00A0;
> > -#endif
> > +
> > ? ? ? ?BCR_writew(trizeps_conxs_bcr);
> > ? ? ? ?board_backlight_power(1);
> > ?}
> > --
> > 1.7.0.4
> >
> >
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 



-- 
--------------------------------------------------------------
J?rgen Schindele  
--------------------------------------------------------------
