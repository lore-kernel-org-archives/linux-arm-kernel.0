From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 13 Nov 2018 09:13:11 -0800
Subject: [PATCH v3 1/4] dt-bindings: hwlock: Document STM32 hwspinlock
 bindings
In-Reply-To: <20181113021337.GA7237@bogus>
References: <20181112152342.6561-1-benjamin.gaignard@st.com>
 <20181112152342.6561-2-benjamin.gaignard@st.com>
 <20181113021337.GA7237@bogus>
Message-ID: <20181113171311.GE10915@tuxbook-pro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 12 Nov 18:13 PST 2018, Rob Herring wrote:

> On Mon, Nov 12, 2018 at 04:23:39PM +0100, Benjamin Gaignard wrote:
> > Add bindings for STM32 hardware spinlock device
> > 
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> 
> Linaro or ST? Please make the author email match.
> 

Thanks for the review Rob and thanks for spotting this.

@Benjamin, please resend the driver and dt-binding with matching author
and sob - or if you wrote this as ST and want to send it upstream as
Linaro add your new sob after the ST one.

Regards,
Bjorn

> > ---
> > version 3 :
> > - fix clock name in properties description
> > version 2 :
> > - change clock name from hwspinlock to hsem to be align with hardware
> >   documentation
> > 
> >  .../bindings/hwlock/st,stm32-hwspinlock.txt        | 23 ++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> > new file mode 100644
> > index 000000000000..adf4f000ea3d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> > @@ -0,0 +1,23 @@
> > +STM32 Hardware Spinlock Device Binding
> > +-------------------------------------
> > +
> > +Required properties :
> > +- compatible : should be "st,stm32-hwspinlock".
> > +- reg : the register address of hwspinlock.
> > +- #hwlock-cells : hwlock users only use the hwlock id to represent a specific
> > +	hwlock, so the number of cells should be <1> here.
> > +- clock-names : Must contain "hsem".
> > +- clocks : Must contain a phandle entry for the clock in clock-names, see the
> > +	common clock bindings.
> > +
> > +Please look at the generic hwlock binding for usage information for consumers,
> > +"Documentation/devicetree/bindings/hwlock/hwlock.txt"
> > +
> > +Example of hwlock provider:
> > +	hwspinlock at 4c000000 {
> > +		compatible = "st,stm32-hwspinlock";
> > +		#hwlock-cells = <1>;
> > +		reg = <0x4c000000 0x400>;
> > +		clocks = <&rcc HSEM>;
> > +		clock-names = "hsem";
> > +	};
> > -- 
> > 2.15.0
> > 
