From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 3 Dec 2014 15:52:35 +0100
Subject: [PATCH v3 02/11] mfd: syscon: Add Atmel Matrix bus DT binding
 documentation
In-Reply-To: <547F1F11.5090803@atmel.com>
References: <1417429647-3419-1-git-send-email-boris.brezillon@free-electrons.com>
 <1417429647-3419-3-git-send-email-boris.brezillon@free-electrons.com>
 <547F1F11.5090803@atmel.com>
Message-ID: <20141203155235.5c5b4a2d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Wed, 3 Dec 2014 15:32:49 +0100
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> Le 01/12/2014 11:27, Boris Brezillon a ?crit :
> > The Matrix registers are provided to configure internal bus behavior on
> > at91 SoCs.
> > Some registers might be access by several drivers (e.g. to configure
> > external memory bus timings), hence we declare this register set as a
> > syscon device.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  .../devicetree/bindings/mfd/atmel-matrix.txt       | 24 ++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-matrix.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/atmel-matrix.txt b/Documentation/devicetree/bindings/mfd/atmel-matrix.txt
> > new file mode 100644
> > index 0000000..e56e27a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/atmel-matrix.txt
> > @@ -0,0 +1,24 @@
> > +* Device tree bindings for Atmel Bus Matrix
> > +
> > +The Bus Matrix registers are used to configure Atmel SoCs internal bus
> > +behavior (master/slave priorities, undefined burst length type, ...)
> > +
> > +Required properties:
> > +- compatible:		Should be one of the following
> > +			"atmel,at91sam9260-matrix", "syscon"
> > +			"atmel,at91sam9261-matrix", "syscon"
> > +			"atmel,at91sam9263-matrix", "syscon"
> > +			"atmel,at91sam9263-matrix", "syscon"
> 
> Same string as the preceding one: shouldn't it be at91sam9rl?

Indeed, and macro definitions for the 9rl are also missing in the
atmel-matrix.h header.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
