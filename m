From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 14 Sep 2013 18:31:37 +0200
Subject: [RFC PATCH alt 4/4] pinctrl: at91: rework debounce configuration
In-Reply-To: <52339479.6030402@wwwdotorg.org>
References: <1379058213-3245-1-git-send-email-b.brezillon@overkiz.com>
 <1379058813-3489-1-git-send-email-b.brezillon@overkiz.com>
 <52339479.6030402@wwwdotorg.org>
Message-ID: <20130914163137.GA11420@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:40 Fri 13 Sep     , Stephen Warren wrote:
> On 09/13/2013 01:53 AM, Boris BREZILLON wrote:
> > AT91 SoCs do not support per pin debounce time configuration.
> > Instead you have to configure a debounce time which will be used for all
> > pins of a given bank (PIOA, PIOB, ...).
> 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
> 
> > +Optional properties for iomux controller:
> > +- atmel,default-debounce-div: array of debounce divisors (one divisor per bank)
> > +  which describes the debounce timing in use for all pins of a given bank
> > +  configured with the DEBOUNCE option (see the following description).
> > +  Debounce timing is obtained with this formula:
> > +  Tdebounce = 2 * (debouncediv + 1) / Fslowclk
> > +  with Fslowclk = 32KHz
> > +
> >  Required properties for pin configuration node:
> >  - atmel,pins: 4 integers array, represents a group of pins mux and config
> >    setting. The format is atmel,pins = <PIN_BANK PIN_BANK_NUM PERIPH CONFIG>.
> > @@ -91,7 +99,6 @@ DEGLITCH	(1 << 2): indicate this pin need deglitch.
> >  PULL_DOWN	(1 << 3): indicate this pin need a pull down.
> >  DIS_SCHMIT	(1 << 4): indicate this pin need to disable schmit trigger.
> >  DEBOUNCE	(1 << 16): indicate this pin need debounce.
> > -DEBOUNCE_VAL	(0x3fff << 17): debounce val.
> 
> This change would break the DT ABI since it removes a feature that's
> already present.
> 
> I suppose it's still up to the Atmel maintainers to decide whether this
> is appropriate, or whether the impact to out-of-tree DT files would be
> problematic.

I does ask Boris to break the DT ABI

as anyway no one use it and the current ABI is wrong

and as this is the new SoC the impact of out-of-tree board is limited if ever

Best Regards,
J.
