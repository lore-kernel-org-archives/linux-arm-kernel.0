From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 Jan 2015 10:18:56 +0000
Subject: [PATCH v3 1/3] dt-bindings: mfd: add lubbock-io binding
In-Reply-To: <87lhkyh8m3.fsf@free.fr>
References: <1421406010-14851-1-git-send-email-robert.jarzmik@free.fr>
 <20150119083533.GF21886@x1> <87lhkyh8m3.fsf@free.fr>
Message-ID: <20150120101856.GO5767@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Jan 2015, Robert Jarzmik wrote:
> Lee Jones <lee.jones@linaro.org> writes:
> > On Fri, 16 Jan 2015, Robert Jarzmik wrote:
> >
> >> Add a binding for lubbock motherboard IO board.
> >> 
> >> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> >> ---
> >>  .../devicetree/bindings/mfd/lubbock-io.txt         | 26 ++++++++++++++++++++++
> >>  1 file changed, 26 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mfd/lubbock-io.txt
> >> 
> >> diff --git a/Documentation/devicetree/bindings/mfd/lubbock-io.txt b/Documentation/devicetree/bindings/mfd/lubbock-io.txt
> >> new file mode 100644
> >> index 0000000..33c9e21
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mfd/lubbock-io.txt
> >> @@ -0,0 +1,26 @@

[...]

> >> +This is the motherboard, or IO board, of the pxa25x development system,
> >> +supporting a lubbock pxa25x SoC board.
> >
> > Again, this sounds weird.
> Would it sound better with :
>   This regroups all the CPLDs on the Lubbock motherboard, providing interrupt
>   muxing, leds handling, ...

Sounds a lot better, yes.

[...]

> >> +  - interrupts : The first interrupt is the line the /IRQ signal the IO board
> >> +                 multiplex is connected to. The only known case is GPIO0 on the
> >> +                 pxa25x SoC.
> >
> > Can you get someone to help you re-word this into a more fluid
> > sentence?
> Aouch, how about this :

:)

> interrupts : The first interrupt is the SoC input interrupt connected to the
>              lubbock IO board interrupt multiplexer output. The only known
>              working configuration is GPIO0 on the pxa25x SoC.

Perfect.

[...]

> > I'm guessing mb means motherboard?  I think it's unusual for a
> > motherboard to have it's own driver.  Usually we provide drivers for
> > the individual components/peripherals situated on the board.
> Yes, mb for motherboard. Well, this driver is actually for the CPLDs on the
> motherboard.  Would "lubbock-cplds" be a better choice ?

That would fit better with my current understanding of what requires a
driver and what does not.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
