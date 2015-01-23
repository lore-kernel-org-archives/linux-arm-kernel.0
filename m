From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Fri, 23 Jan 2015 10:39:00 +0100
Subject: [PATCHv6 2/5] USB: gadget: atmel_usba_udc: Request an auto
 disabled Vbus signal IRQ instead of an auto enabled IRQ request followed by
 IRQ disable
In-Reply-To: <54C20D8E.4040505@atmel.com>
References: <1421945805-31129-1-git-send-email-sylvain.rochet@finsecur.com>
 <1421945805-31129-3-git-send-email-sylvain.rochet@finsecur.com>
 <0F74BBB2-B515-4A36-8C71-25F58A4D1AB6@jcrosoft.com>
 <54C20D8E.4040505@atmel.com>
Message-ID: <20150123093900.GA30664@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Jan 23, 2015 at 09:59:58AM +0100, Nicolas Ferre wrote:
> Le 23/01/2015 08:43, Jean-Christophe PLAGNIOL-VILLARD a ?crit :
> > > On Jan 23, 2015, at 12:56 AM, Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:
> > > +			irq_set_status_flags(gpio_to_irq(udc->vbus_pin),
> > > +					IRQ_NOAUTOEN);
> > 
> > not happy about still using the broken gpio_to_irq API
> > 
> > Linus can pass the IRQ via board file?
> > 
> > and via DT we can use IRQ directly

Although I agree on the general principle, this driver is also used by 
non-DT boards.

I have concerns at least for at32ap700x-based boards which use this 
driver and are non-DT. The suggested change requires changing platform 
data of at32ap700x in such a way we may break it in my opinion.


> Absolutely not the topic of this patch series.
> Maybe the subject of another patch later?

Indeed. This series is only about PM support, harmless rework, or 
necessary rework for PM. Changing the way we acquire the IRQ is not 
harmless, this should be checked carefully for DT and particularly 
non-DT boards.


Sylvain
