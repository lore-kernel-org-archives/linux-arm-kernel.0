From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Nov 2012 13:40:57 +0100
Subject: [PATCH 15/16] irqchip: vic: mark vic_of_init() as static
In-Reply-To: <1353448867-15008-16-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1353448867-15008-16-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdazuvjXuuNP9TrsYsPQWMc=VV_-nu0oNWFPs+GzLmmw2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 11:01 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> With all vic_of_init() users converted to the irqchip infrastructure,
> there is no longer a reason for this function to be
> exported. Therefore, mark it as static.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

It may be that I have missed some patches, but are really all VIC
users converted in this patch series?

In arch/arm/mach-u300/core.c I have this:
        vic_init((void __iomem *) U300_INTCON0_VBASE, IRQ_U300_INTCON0_START,
                 mask[0], mask[0]);
        vic_init((void __iomem *) U300_INTCON1_VBASE, IRQ_U300_INTCON1_START,
                 mask[1], mask[1]);

arch/arm/mach-nomadik/cpu-8815.c:

        /* This modified VIC cell has two register blocks, at 0 and 0x20 */
        vic_init(io_p2v(NOMADIK_IC_BASE + 0x00), IRQ_VIC_START +  0, ~0, 0);
        vic_init(io_p2v(NOMADIK_IC_BASE + 0x20), IRQ_VIC_START + 32, ~0, 0);

And there are more still I think? I didn't see those converted so
I guess I must have missed some patches or something?

PS please make sure u300_defconfig and nhk8815_defconfig builds, or
I will be a sad puppy ...

Yours,
Linus Walleij
