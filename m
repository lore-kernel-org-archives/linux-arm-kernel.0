From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 31 May 2013 03:20:08 +0200
Subject: [RFC/PATCH v2 2/2] gpio-rcar: Add DT support
In-Reply-To: <CACRpkdb8GYpx3ASzXB7HX5oEpAUBe-yBo0N5Ep9S+DqoE6oCLw@mail.gmail.com>
References: <1369136406-23800-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1369136406-23800-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CACRpkdb8GYpx3ASzXB7HX5oEpAUBe-yBo0N5Ep9S+DqoE6oCLw@mail.gmail.com>
Message-ID: <4678059.RuWR6CiQ8n@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thursday 30 May 2013 19:38:12 Linus Walleij wrote:
> On Tue, May 21, 2013 at 1:40 PM, Laurent Pinchart
> <laurent.pinchart+renesas@ideasonboard.com> wrote:
> > Add DT bindings for the gpio-rcar driver and read the device
> > configuration from the DT node at probe time if available.
> > 
> > Cc: devicetree-discuss at lists.ozlabs.org
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I am assuming this will go through Simon's tree?

I've so far pushed GPIO and pinctrl patches for SH through Simon's tree due to 
the many cross-dependencies between SH arch code and the GPIO and pinctrl 
drivers. As the situation now stabilizes, we could now push the patches 
through their respective subsystem trees.

Simon, Linus, any opinion/preference on that ?

> Note:
> > +  - gpio-ranges: Range of pins managed by the GPIO controller as a
> > 4-cells
> > +    tuple using the following syntax.
> > +
> > +    <[phandle of the pin controller node]
> > +     0
> > +     [index of the first pin]
> > +     [number of pins]>
> > +
> > +Please refer to gpio.txt in this directory for details of the common GPIO
> > +bindings used by client devices.
> 
> The above ranges are part of that document.

What about replacing that with

  - gpio-ranges: Range of pins managed by the GPIO controller.

Please refer to gpio.txt in this directory for details of gpio-ranges property 
and the common GPIO bindings used by client devices.

-- 
Regards,

Laurent Pinchart
