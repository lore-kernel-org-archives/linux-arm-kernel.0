From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 15:03:15 +0100
Subject: [PATCH v2 2/5] ARM: gic: remove direct use of gic_raise_softirq
In-Reply-To: <50AA39A4.1060006@gmail.com>
References: <1351695517-5636-1-git-send-email-robherring2@gmail.com>
 <1351695517-5636-3-git-send-email-robherring2@gmail.com>
 <20121102124433.GA28213@bnru03> <20121119115021.GA19788@bnru10>
 <20121119130718.025b7a2c@skate> <50AA39A4.1060006@gmail.com>
Message-ID: <20121119150315.2a0ecd4f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Mon, 19 Nov 2012 07:52:36 -0600, Rob Herring wrote:

> > I have merged Linus Walleij patches into my irqchip branch with more
> > changes around the irqchip infrastructure. That said, it will not be
> > part of the 3.8 release cycle, so we will definitely take care of
> > re-spinning against the latest ux500 changes.
> 
> I still hope to get some of the clean-up in for 3.8 if not the move
> itself. So I can include your patch. Is it in an arm-soc branch already?

No, not yet. My goal was to send soon a new RFC version of the patches.
In case you want to have a look, here is what I have for now:

 https://github.com/MISL-EBU-System-SW/mainline-public/commits/irqchip-improvements

Or the irqchip-improvements branch at
git at github.com:MISL-EBU-System-SW/mainline-public.git.

This is a heavily work-in-progress branch. Compared to the previous
version, the most significant changes are:

 * Integration of your GIC/VIC patches.

 * Usage of a linker script trick to accumulate the available irqchip
   drivers in order to avoid the global list in irqchip.{c,h} which
   would otherwise become a conflict nightmare.

 * More VIC cleanup patches so that vic_of_init() doesn't need to be
   exposed anymore.

 * Implementation of Arnd's idea of set_handle_irq() in the core ARM
   code.

Remains to be done:

 * Testing.

 * Validate that the linker script solution is acceptable.

 * Integrate Linus Walleij patches moving the FPGA irq controller code
   to drivers/irqchip/.

 * Solve Russell's comment about the header file location.

I'm hoping to make some progress on this either tomorrow or the day
after, but I think it's mostly 3.9 material at this point as we have
quite a few remaining problems to solve (the header file location for
gic and vic being the most important ones I'd say).

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
