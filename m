From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Mon, 16 Jul 2018 21:30:55 +0200
Subject: [PATCH v4 10/14] dt-bindings/interrupt-controller: update
 Marvell ICU bindings
In-Reply-To: <20180716174402.GA28988@rob-hp-laptop>
References: <20180705124011.7661-1-miquel.raynal@bootlin.com>
 <20180705124011.7661-11-miquel.raynal@bootlin.com>
 <20180716152734.GA4581@rob-hp-laptop>
 <20180716183935.36f48f76@xps13>
 <20180716174402.GA28988@rob-hp-laptop>
Message-ID: <20180716213055.1f9c428e@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 16 Jul 2018 11:44:02 -0600, Rob Herring wrote:

> > > I raised this before and still don't understand. You had 4 types before 
> > > and now you only have 2 types? How do you handle SR and REI with the new 
> > > binding?  
> > 
> > Indeed there are 4 types: NSR, SR, SEI, REI.
> > 
> > Until now only NSR were supported.  
> 
> All 4 were supported by the binding and now only 2 though.

In fact, no, the old binding was not working for anything but NSR. It
pretended to support SEI, REI and SR, but because these had never been
implemented, the binding was not sufficient to over them.

To support SEI or REI, we need to point to a different msi-parent than
the one used for NSR, which wasn't possible with the previous binding.

So there is no regression of functionality by this binding change,
quite the contrary, as it really allows to add SEI support, which was
not possible before. You can consider that the previous binding was
buggy and dysfunctional.

Best regards,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
