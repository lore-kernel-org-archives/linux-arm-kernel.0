From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 21 Nov 2012 13:53:57 +0100
Subject: [PATCH 15/16] irqchip: vic: mark vic_of_init() as static
In-Reply-To: <CACRpkdazuvjXuuNP9TrsYsPQWMc=VV_-nu0oNWFPs+GzLmmw2g@mail.gmail.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1353448867-15008-16-git-send-email-thomas.petazzoni@free-electrons.com>
 <CACRpkdazuvjXuuNP9TrsYsPQWMc=VV_-nu0oNWFPs+GzLmmw2g@mail.gmail.com>
Message-ID: <20121121135357.5c963404@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Linus Walleij,

On Wed, 21 Nov 2012 13:40:57 +0100, Linus Walleij wrote:
> On Tue, Nov 20, 2012 at 11:01 PM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> 
> > With all vic_of_init() users converted to the irqchip infrastructure,
> > there is no longer a reason for this function to be
> > exported. Therefore, mark it as static.
> >
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> It may be that I have missed some patches, but are really all VIC
> users converted in this patch series?
> 
> In arch/arm/mach-u300/core.c I have this:
>         vic_init((void __iomem *) U300_INTCON0_VBASE, IRQ_U300_INTCON0_START,
>                  mask[0], mask[0]);
>         vic_init((void __iomem *) U300_INTCON1_VBASE, IRQ_U300_INTCON1_START,
>                  mask[1], mask[1]);
> 
> arch/arm/mach-nomadik/cpu-8815.c:
> 
>         /* This modified VIC cell has two register blocks, at 0 and 0x20 */
>         vic_init(io_p2v(NOMADIK_IC_BASE + 0x00), IRQ_VIC_START +  0, ~0, 0);
>         vic_init(io_p2v(NOMADIK_IC_BASE + 0x20), IRQ_VIC_START + 32, ~0, 0);
> 
> And there are more still I think? I didn't see those converted so
> I guess I must have missed some patches or something?

In this patch series, I'm making vic_of_init() static. vic_init() used
by non-DT platforms is kept as is, with no change, so I'm not sure why
you're worried about vic_init() being a problem.

> PS please make sure u300_defconfig and nhk8815_defconfig builds, or
> I will be a sad puppy ...

Indeed. The whole thing needs more testing, for sure. I guess I should
have labeled it as RFC, because it's really what it is.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
