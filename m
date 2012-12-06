From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 Dec 2012 16:03:03 -0800
Subject: [PATCH v7 5/5] ARM: OMAP: gpmc: add DT bindings for GPMC
 timings and NAND
In-Reply-To: <20121205232426.BAD573E0E22@localhost>
References: <1354734571-10774-1-git-send-email-zonque@gmail.com>
 <1354734571-10774-6-git-send-email-zonque@gmail.com>
 <20121205222232.67B2B3E0E22@localhost> <50BFCBCC.6030706@ti.com>
 <20121205232426.BAD573E0E22@localhost>
Message-ID: <20121206000302.GM21682@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grant Likely <grant.likely@secretlab.ca> [121205 15:26]:
> On Wed, 5 Dec 2012 16:33:48 -0600, Jon Hunter <jon-hunter@ti.com> wrote:
> > On 12/05/2012 04:22 PM, Grant Likely wrote:
> > > 
> > > Please, be specific. Use something like "ti,am3340-gpmc" or
> > > "ti,omap3430-gpmc". The compatible property is a list so that new
> > > devices can claim compatibility with old. Compatible strings that are
> > > overly generic are a pet-peave of mine.
> > 
> > We aim to use the binding for omap2,3,4,5 as well as the am33xx devices
> > (which are omap based). Would it be sufficient to have "ti,omap2-gpmc"
> > implying all omap2+ based devices or should we have a compatible string
> > for each device supported?
> 
> Are they each register-level compatible with one another?
> 
> The general recommended approach here is to make subsequent silicon
> claim compatibility with the first compatible implementation.
> 
> So, for an am3358 board:
> 	compatible = "ti,am3358-gpmc", "ti,omap2420-gpmc";
> 
> Essentially, what this means is that "ti,omap2420-gpmc" is the generic
> value instead of "omap2-gpmc". The reason for this is so that the value
> is anchored against a specific implementation, and not against something
> completely imaginary or idealized. If a newer version isn't quite
> compatible with the omap2420-gpmc, then it can drop the compatible claim
> and the driver really should be told about the new device.

The compatible property can also be used to figure out which ones
need the workarounds in patch #4 of this series for the DT case.
So we should be specific with the compatible.

Regards,

Tony
