From: tony@atomide.com (Tony Lindgren)
Date: Wed, 22 May 2013 08:34:52 -0700
Subject: [PATCH 2/5] ARM: dts: OMAP2+: create a DT header for GPIO
In-Reply-To: <519CE3BB.3040704@wwwdotorg.org>
References: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch>
 <1369232864-14460-3-git-send-email-florian.vaussard@epfl.ch>
 <519CE3BB.3040704@wwwdotorg.org>
Message-ID: <20130522153452.GZ10378@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren <swarren@wwwdotorg.org> [130522 08:32]:
> On 05/22/2013 08:27 AM, Florian Vaussard wrote:
> > Define the OMAP_GPIO macro to conveniently use GPIO inside OMAP DT.
> > For example:
> > 
> > 	gpios = <&gpio6 3 0>;  /* GPIO 163 */
> > 
> > can be replaced by
> > 
> > 	gpios = OMAP_GPIO(163, 0);
> 
> > diff --git a/include/dt-bindings/gpio/omap-gpio.h b/include/dt-bindings/gpio/omap-gpio.h
> 
> > +#define OMAP_GPIO_0_BANK        gpio1
> > +#define OMAP_GPIO_1_BANK        gpio1
> > +#define OMAP_GPIO_2_BANK        gpio1
> > +#define OMAP_GPIO_3_BANK        gpio1
> 
> There are a /lot/ of those. Is this really worth it?
> 
> If the OMAP GPIO HW is already represented as a bunch of separate DT
> nodes which represent separate GPIO blocks, then I would have thought
> the syntax <&gpioN M 0> more directly represents what would be found in
> the HW manual? If not, surely the DT should have a single node to
> represent a single GPIO controller, which just happens to internally
> support a bunch of register arrays.

Yes I agree, let's not go back to numbering anything except within the
a single instance. If anything, we can put the gpio number into comments.

Regards,

Tony
