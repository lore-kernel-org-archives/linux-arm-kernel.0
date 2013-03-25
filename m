From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Mar 2013 14:11:43 +0000
Subject: [PATCH 5/6] ARM: ux500: move PRCMU functions into the CPUidle
 driver
In-Reply-To: <CACRpkdab+iT4m5gDtuH2vYpRQRgTyOho4=s+zj0cEDfxE5g_FQ@mail.gmail.com>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <51505816.1020302@linaro.org>
 <CACRpkdab+iT4m5gDtuH2vYpRQRgTyOho4=s+zj0cEDfxE5g_FQ@mail.gmail.com>
Message-ID: <201303251411.43356.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 March 2013, Linus Walleij wrote:
> On Mon, Mar 25, 2013 at 2:58 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> > On 03/25/2013 02:44 PM, Linus Walleij wrote:
> 
> >> Shall I put it in <linux/platform_data/arm-ux500-pm.h> or so,
> >> with the implementation in arch/arm/mach-ux500/pm.c
> >> or so?
> >
> > Wouldn't <asm/pm.h> be better ? So we can have the same header name for
> > all the drivers, no ?
> 
> I don't think that works with multiplatform. When building multiple
> systems our approach is to not let any two header files have the same
> name.
> 
> What we did for debug macro for example was to create the <debug/*>
> namespace, so the old <mach/debug-macro.S> is now <debug/imx.S>,
> <debug/vt8500.h>, <debug/ux500.h> ... etc.
> 
> So what would be needed would then rather be <pm/*> in
> arch/arm/include/pm and under this we would create
> <pm/ux500.h>.
> 
> But that require Russell and Arnds/Olofs consent I think,
> what do you guys say? Other recommendations?

I would first like to understand what contents you actually need to
have in the header file.

	Arnd
