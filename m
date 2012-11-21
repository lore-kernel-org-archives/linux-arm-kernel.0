From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 21 Nov 2012 13:47:25 +0100
Subject: [PATCH 16/16] ARM: plat-versatile: move FPGA irq driver to
 drivers/irqchip
In-Reply-To: <CACRpkdai62ox=fJ31viCOVfNc1skEEr+7356PEf0y1j6jzDrdw@mail.gmail.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1353448867-15008-17-git-send-email-thomas.petazzoni@free-electrons.com>
 <CACRpkdai62ox=fJ31viCOVfNc1skEEr+7356PEf0y1j6jzDrdw@mail.gmail.com>
Message-ID: <20121121134725.69b4e8e8@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On Wed, 21 Nov 2012 13:22:27 +0100, Linus Walleij wrote:

> > This moves the Versatile FPGA interrupt controller driver, used in
> > the Integrator/AP, Integrator/CP and some Versatile boards, out
> > of arch/arm/plat-versatile and down to drivers/irqchip where we
> > have consensus that such drivers belong. The header file is
> > consequently moved to <linux/platform_data/irq-versatile-fpga.h>.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> It appears you have modified my commit so this is not the
> whole story right?
> 
> This doesn't look like I wrote it:
> +IRQCHIP_DECLARE(versatile_fpga_irq, "arm,versatile-fpga-irq",
> +               fpga_irq_of_init);
> +

Right, sorry. As I said earlier, this v4 is not intended for merging,
but only to show the current state, and define together what remains to
be fixed/changed.

> Is it possible to do your changes on top of my commit
> instead?

Not if we want to keep bisectability.

> Atleast add your Signed-off-by please...

Will do, thanks for the notice.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
