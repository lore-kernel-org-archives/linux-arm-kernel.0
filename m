From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 21 Jan 2015 15:10:52 +0000
Subject: [PATCH v3 2/3] mfd: lubbock_io: add lubbock_io board
In-Reply-To: <332399927.402665086.1421847419490.JavaMail.root@zimbra1-e1.priv.proxad.net>
References: <20150121123551.GD9258@x1>
 <332399927.402665086.1421847419490.JavaMail.root@zimbra1-e1.priv.proxad.net>
Message-ID: <20150121151052.GD22024@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Jan 2015, robert.jarzmik at free.fr wrote:

> > ----- Mail original -----
> > De: "Lee Jones" <lee.jones@linaro.org>
> First of all, this is my web mail interface, so please be kind with
> my mail formatting ...

I have no idea what you want me to change or do differently?

Perhaps it might be more prudent for you to switch to a quality
mailer?

> > Looking at one of the other patches in the series it appears the flag
> > you're trying to capture is IORESOURCE_IRQ_LOWEDGE.  When I grep for
> > where this is being _used_ (think 'consumed, rather than passed.  I
> > only see a single entry in drivers/pnp/interface.c.
> Look at this call chain :
> request_irq()
>   setup_irq()
>     __setup_irq()
>       __irq_set_trigger()
>         pxa_gpio_irq_type() (aka. chip->irq_set_type)
>           => hardware register manipulation
> 
> Moreover, you should be aware of the bijection existing between :
>  - IORESOURCE_IRQ_LOWEDGE and IRQF_TRIGGER_RISING
>  - it's HIGHEDGE twin
>  - it is noted in : include/linux/interrupt.h
> 
> > That's what got me thinking... are you sure you're a) making use of
> this flag
> Yes, I'm quite sure.
> 
> > b) assuming the answer to 'a' is "no"
> I won't :)
> 
> > I think to set an edge trigger on an IRQ, you should instead do so via
> > irq_set_irq_type(), or have a missed a line or two?
> __setup_irq(), that's the entry point.

Very well, Russell and yourself have convinced me.  If you fixup the
remainder of comments, I'm happy.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
