From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 18 May 2012 23:49:48 -0600
Subject: [PATCH v4] plat-versatile: modernize FPGA IRQ controller
In-Reply-To: <4F9714BD.4060103@gmail.com>
References: <1334690647-12346-1-git-send-email-linus.walleij@linaro.org>
 <4F9714BD.4060103@gmail.com>
Message-ID: <20120519054948.B978B3E046E@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Apr 2012 16:01:49 -0500, Rob Herring <robherring2@gmail.com> wrote:
> On 04/17/2012 02:24 PM, Linus Walleij wrote:
> > This does two things to the FPGA IRQ controller in the versatile
> > family:
> > 
> > - Convert to MULTI_IRQ_HANDLER so we can drop the entry macro
> >   from the Integrator. The C IRQ handler was inspired from
> >   arch/arm/common/vic.c, recent bug discovered in this handler was
> >   accounted for.
> > - Convert to using IRQ domains so we can get rid of the NO_IRQ
> >   mess and proceed with device tree and such stuff.
> > 
> > As part of the exercise, bump all the low IRQ numbers on the
> > Integrator PIC to start from 1 rather than 0, since IRQ 0 is
> > now NO_IRQ. The Linux IRQ numbers are thus entirely decoupled
> > from the hardware IRQ numbers in this controller.
> > 
> > I was unable to split this patch. The main reason is the half-done
> > conversion to device tree in Versatile.
> > 
> > Tested on Integrator/AP and Integrator/CP.
> > 
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Looks good.
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Ditto.

Acked-by: Grant Likely <grant.likely@secretlab.ca>
