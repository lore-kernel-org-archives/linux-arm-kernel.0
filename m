From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 11 Sep 2014 11:56:28 +0200
Subject: [PATCH v3 8/8] rtc: at91sam9: add DT bindings documentation
In-Reply-To: <20140911094213.GC12295@localhost>
References: <1410425767-17874-1-git-send-email-boris.brezillon@free-electrons.com>
 <1410425767-17874-9-git-send-email-boris.brezillon@free-electrons.com>
 <20140911094213.GC12295@localhost>
Message-ID: <20140911115628.110a403b@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 Sep 2014 11:42:13 +0200
Johan Hovold <johan@kernel.org> wrote:

> On Thu, Sep 11, 2014 at 10:56:07AM +0200, Boris BREZILLON wrote:
> > Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > ---
> >  .../devicetree/bindings/rtc/atmel,at91sam9-rtc.txt | 24 ++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
> > new file mode 100644
> > index 0000000..258a036
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
> > @@ -0,0 +1,24 @@
> > +Atmel AT91SAM9260 Real Time Timer
> > +
> > +Required properties:
> > +- compatible: should be: "atmel,at91sam9260-rtt"
> > +- reg: should encode the memory region of the RTT controller
> > +- interrupts: rtc alarm/event interrupt
> > +- clocks: should contain one clock pointing the the slow clk
> > +- atmel,time-reg: should encode the GPBR register used to store the RTC
> > +		  time. The first cell should point to the GPBR node and
> > +		  the second one encode the offset within the GPBR block
> > +		  (or in other terms, the GPBR register used to store the
> > +		  current time value).
> > +
> > +
> > +
> > +Example:
> > +
> > +rtc at fffffe00 {
> 
> This should be rtt@
> 
> > +	compatible = "atmel,at91sam9260-rtt";
> > +	reg = <0xfffffd20 0x10>;
> > +	interrupts = <1 4 7>;
> > +	clocks = <&clk32k>;
> > +	atmel,time-reg = <&gpbr 0x0>;
> 
> I think the property name could be more descriptive as it is specific to
> when the RTT is used as an RTC. Perhaps, atmel,rtt-rtc-time-reg?

No problem, I'll change both names for the next version.


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
