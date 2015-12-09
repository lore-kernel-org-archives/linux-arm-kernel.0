From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 09 Dec 2015 22:27:32 +0100
Subject: [PATCH] ARM: pxa: mark ezx structures as __maybe_unused
In-Reply-To: <8737vbl595.fsf@belgarion.home>
References: <7455848.ygDvrz6r6S@wuerfel> <8737vbl595.fsf@belgarion.home>
Message-ID: <1880182.PirFZsblMo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 December 2015 21:46:30 Robert Jarzmik wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > The ezx platform contains multiple machine descriptors, but not all
> > of them use all of the data structures, and it's possible to disable
> > all of the machines, which produces some harmless warnings:
> >
> > mach-pxa/ezx.c:53:26: warning: 'ezx_pwm_lookup' defined but not used [-Wunused-variable]
> > mach-pxa/ezx.c:86:31: warning: 'ezx_fb_info_1' defined but not used [-Wunused-variable]
> > mach-pxa/ezx.c:107:31: warning: 'ezx_fb_info_2' defined but not used [-Wunused-variable]
> > mach-pxa/ezx.c:113:32: warning: 'ezx_devices' defined but not used [-Wunused-variable]
> > mach-pxa/ezx.c:117:22: warning: 'ezx_pin_config' defined but not used [-Wunused-variable]
> >
> > This marks all those structures as __maybe_unused to avoid the warnings.
> > Obviously a configuration that contains the ezx platform but no specific
> > model is a bit silly, but it should not cause compile-time warnings.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
> 
> I think you'll take that through your tree, as I'm passing the v4.5 pull. If you
> want me to take them, just tell me, but I think v4.5 is already prepared on your
> side as I've seen a mail from Boris talking about pxa patches going through mtd
> tree for v4.5.

I'll apply them directly, thanks for taking a look! I'm also aware of Boris
patches and don't expect a conflict here but will resolve it in arm-soc
otherwise.

	Arnd
