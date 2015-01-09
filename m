From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 9 Jan 2015 02:34:21 +0100
Subject: [PATCH 1/2] leds: tlc59116: Document binding for the TI 16
 Channel i2c LED driver
In-Reply-To: <CAK5ve-+VNn+NBp_fXq1OZY9DbC90_GmPtLfkL22L5tjNX3xtfw@mail.gmail.com>
References: <1420763178-10115-1-git-send-email-andrew@lunn.ch>
 <1420763178-10115-2-git-send-email-andrew@lunn.ch>
 <CAK5ve-+VNn+NBp_fXq1OZY9DbC90_GmPtLfkL22L5tjNX3xtfw@mail.gmail.com>
Message-ID: <20150109013421.GA10191@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 05:02:07PM -0800, Bryan Wu wrote:
> On Thu, Jan 8, 2015 at 4:26 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> > Document the binding for the TLC59116 LED driver.
> >
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Cc: Matthew.Fatheree at belkin.com
> > ---
> >  .../devicetree/bindings/leds/leds-tlc59116.txt     | 41 ++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/leds-tlc59116.txt
> >
> > diff --git a/Documentation/devicetree/bindings/leds/leds-tlc59116.txt b/Documentation/devicetree/bindings/leds/leds-tlc59116.txt
> > new file mode 100644
> > index 000000000000..9526731eda95
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/leds-tlc59116.txt
> > @@ -0,0 +1,41 @@
> > +LEDs connected to tcl59116
> > +
> > +Required properties
> > +- compatible: should be "ti,tlc59116"
> > +- #address-cells: must be 1
> > +- #size-cells: must be 0
> > +- reg: typically 0x68
> > +
> > +Each led is represented as a sub-node of the ti,,tlc59116.
> > +See Documentation/devicetree/bindings/leds/common.txt
> > +
> > +LED sub-node properties:
> > +- reg: number of LED line, 0 to 15
> > +- label: (optional) name of LED
> > +- linux,default-trigger : (optional)
> > +
> > +Examples:
> > +
> > +tlc59116 at 68 {
> > +       #address-cells = <1>;
> > +       #size-cells = <0>;
> > +       #gpio-cells = <2>;
> 
> What's gpio-cells for? Or missing document?

Hi Bryan

It should be removed. I probably copied it from tca6507.txt binding
documentation. This driver makes no attempt to also offer the pins are
gpio lines.

     Andrew

 
> > +       compatible = "ti,tlc59116";
> > +       reg = <0x68>;
> > +
> > +       wan at 0 {
> > +               label = "wrt1900ac:amber:wan";
> > +               reg = <0x0>;
> > +       };
> > +
> > +       2g at 2 {
> > +               label = "wrt1900ac:white:2g";
> > +               reg = <0x2>;
> > +       };
> > +
> > +       alive at 9 {
> > +               label = "wrt1900ac:green:alive";
> > +               reg = <0x9>;
> > +               linux,default_trigger = "heartbeat";
> > +       };
> > +};
> > --
> > 2.1.3
> >
