From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Mar 2014 23:06:43 +0100
Subject: [PATCH 1/3] IXP4xx: Fix Goramo Multilink GPIO conversion.
In-Reply-To: <CACRpkdaNdQjgAJv=mxn6MXS+kGKFoE4wmNHxYt_5WdM9sa6vxA@mail.gmail.com>
References: <m3siq9iyt2.fsf@intrepid.localdomain>
 <m3bnwxiwhj.fsf@intrepid.localdomain>
 <CACRpkdaNdQjgAJv=mxn6MXS+kGKFoE4wmNHxYt_5WdM9sa6vxA@mail.gmail.com>
Message-ID: <201403262306.43920.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 March 2014, Linus Walleij wrote:
> On Sun, Mar 23, 2014 at 1:34 AM, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> 
> > arch/arm/mach-ixp4xx/goramo_mlr.c: In function 'set_scl':
> > arch/arm/mach-ixp4xx/goramo_mlr.c:82: error: implicit declaration of function 'gpio_line_set'
> >
> > arch/arm/mach-ixp4xx/goramo_mlr.c: In function 'output_control':
> > arch/arm/mach-ixp4xx/goramo_mlr.c:111: error: implicit declaration of function 'gpio_line_config'
> > arch/arm/mach-ixp4xx/goramo_mlr.c:111: error: 'IXP4XX_GPIO_OUT' undeclared
> >
> > arch/arm/mach-ixp4xx/goramo_mlr.c: In function 'hss_dcd_irq':
> > arch/arm/mach-ixp4xx/goramo_mlr.c:155: error: implicit declaration of function 'gpio_line_get'
> >
> > arch/arm/mach-ixp4xx/goramo_mlr.c: In function 'gmlr_init':
> > arch/arm/mach-ixp4xx/goramo_mlr.c:416: error: 'IXP4XX_GPIO_OUT' undeclared
> > arch/arm/mach-ixp4xx/goramo_mlr.c:421: error: 'IXP4XX_GPIO_IN' undeclared
> >
> > Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Mea culpa.
> 
> Arnd: can you apply this one patch directly for ARM SoC fixes and
> Cc: stable at vger.kernel.org on this one?
> 
> Alternatively can you send this for fixes to arm at kernel.org with Cc:
> stable added Krzysztof?

I reverted my earlier patch and applied this instead. Thanks a lot!

Did not add a stable tag, as suggested by Krzysztof.

	Arnd
