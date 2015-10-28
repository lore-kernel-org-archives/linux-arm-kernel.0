From: pramodku@broadcom.com (Pramod Kumar)
Date: Wed, 28 Oct 2015 05:14:34 +0000
Subject: [PATCH 05/11] dt-binding: Add ngpios property to GPIO
 controller node
In-Reply-To: <CACRpkdZRmJTF9_yzVJx_vPKH6M6PivcrPiLD7xMEs5HDvsLw7g@mail.gmail.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
 <1445233398-27129-6-git-send-email-pramodku@broadcom.com>
 <CACRpkdZRmJTF9_yzVJx_vPKH6M6PivcrPiLD7xMEs5HDvsLw7g@mail.gmail.com>
Message-ID: <0C803592FC378B4E83922050AB46442A2AD73E7A@SJEXCHMB10.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij at linaro.org]
> Sent: 27 October 2015 15:11
> To: Pramod Kumar
> Cc: Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell; Kumar Gala; Ray Jui;
> Scott Branden; Russell King; linux-gpio at vger.kernel.org; bcm-kernel-feedback-
> list; Jason Uy; Masahiro Yamada; Thomas Gleixner; Laurent Pinchart;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; Jonas Gorski
> Subject: Re: [PATCH 05/11] dt-binding: Add ngpios property to GPIO controller
> node
> 
> On Mon, Oct 19, 2015 at 7:43 AM, Pramod Kumar <pramodku@broadcom.com>
> wrote:
> 
> > Add ngpios property to the gpio controller's DT node so that
> > controller driver extracts total number of gpio lines present in
> > controller from DT and removes dependency on driver.
> >
> > Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
> > Reviewed-by: Ray Jui <rjui@broadcom.com>
> > Reviewed-by: Scott Branden <sbranden@broadcom.com>
> (...)
> > +- ngpios:
> > +    Total number of GPIOs the controller provides
> 
> This description is wrong. The number of GPIOs the controller *provides* is to
> be determined by the compatible-string.
> 
> ngpios is used to restrict the number of lines *used* or *routed* from the
> number *available*. (I hope that is what the code does as well.) Such as if 12
> GPIOs are used of the 32 available on 32bits in a register.
> 
> Update this description to say what it really means.
> 
> Yours,
> Linus Walleij

Thanks for reviewing . Will update the description.

Regards,
Pramod
