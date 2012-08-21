From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 21 Aug 2012 10:23:29 +0100
Subject: [PATCH 8/8] input: ab8500-ponkey: Rely on MFD core to convert
 IRQs to virtual
In-Reply-To: <CACRpkdZ-HOGy_sdsCQSNOdYTDzHFszk0OySM88TjO-neSJUz0A@mail.gmail.com>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-9-git-send-email-lee.jones@linaro.org>
 <CACRpkdZ-HOGy_sdsCQSNOdYTDzHFszk0OySM88TjO-neSJUz0A@mail.gmail.com>
Message-ID: <20120821092328.GC26899@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 10:31:08AM +0200, Linus Walleij wrote:
> On Thu, Aug 9, 2012 at 5:53 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > There was a plan to place ab8500_irq_get_virq() calls in each AB8500
> > child device prior to requesting an IRQ, but as we're no longer using
> > Device Tree to collect our IRQ numbers, it's actually better to allow
> > the core to do this during device registration time. So the IRQ number
> > we pull from its resource has already been converted to a virtual IRQ.
> >
> > CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > CC: linux-input at vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> This is looking good, I guess you need all patches to go in at the
> same time so Dmitry's ACK is required.

Yep, just waiting for that now.
 
> FWIW:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> BTW: this makes me suspect that the public ab8500_irq_get_virq()
> interface can be *deleted* and the function made static in the
> AB8500 driver, right?

Right. Already taken care of.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
