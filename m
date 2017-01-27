From: oss@buserror.net (Scott Wood)
Date: Fri, 27 Jan 2017 17:51:42 -0600
Subject: [PATCH 1/3] dt-bindings: qoriq-clock: Add coreclk
In-Reply-To: <20170127223819.mzovhnnpths5t5w2@rob-hp-laptop>
References: <1485332363-8434-1-git-send-email-oss@buserror.net>
 <20170127223819.mzovhnnpths5t5w2@rob-hp-laptop>
Message-ID: <1485561102.9266.8.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-01-27 at 16:38 -0600, Rob Herring wrote:
> On Wed, Jan 25, 2017 at 02:19:21AM -0600, Scott Wood wrote:
> > 
> > ls1012a has separate input root clocks for core PLLs versus the platform
> > PLL, with the latter described as sysclk in the hw docs.
> > 
> > Update the qoriq-clock binding to allow a second input clock, named
> > "coreclk".??If present, this clock will be used for the core PLLs.
> > 
> > Signed-off-by: Scott Wood <oss@buserror.net>
> > Cc: devicetree at vger.kernel.org
> > ---
> > ?Documentation/devicetree/bindings/clock/qoriq-clock.txt | 6 ++++++
> > ?1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> > b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> > index df9cb5a..97a9666 100644
> > --- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> > +++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> > @@ -55,6 +55,11 @@ Optional properties:
> > ?- clocks: If clock-frequency is not specified, sysclk may be provided
> > ?	as an input clock.??Either clock-frequency or clocks must be
> > ?	provided.
> > +	A second input clock, called "coreclk", may be provided if
> > +	core PLLs are based on a different input clock from the
> > +	platform PLL.
> > +- clock-names: Required if a coreclk is present.??Valid names are
> > +	"sysclk" and "coreclk".
> 'clk' part is redundant.

"sysclk" is a term used by the hardware documentation and I'd rather leave it
intact. ?"coreclk" isn't named (only described) by the hardware documentation
but it is a special variant of sysclk and having similar naming helps make
that clear.

-Scott
