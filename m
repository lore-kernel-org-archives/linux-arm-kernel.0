From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Dec 2016 17:40:28 -0600
Subject: [resend v2: PATCH 1/2] dt-bindings: Document the hi3660 reset
 bindings
In-Reply-To: <1480687813.2460.19.camel@pengutronix.de>
References: <1480553321-17400-1-git-send-email-zhangfei.gao@linaro.org>
 <3900806.3NUubBDb0Q@wuerfel>
 <e15e76e2-b32d-a4d0-eb8b-850626a3946a@linaro.org>
 <5982682.vMJxVociDa@wuerfel>
 <1480687813.2460.19.camel@pengutronix.de>
Message-ID: <20161205234028.niukdkygbdni5gvm@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 03:10:13PM +0100, Philipp Zabel wrote:
> Am Freitag, den 02.12.2016, 13:32 +0100 schrieb Arnd Bergmann:
> > On Friday, December 2, 2016 8:21:33 AM CET zhangfei wrote:
> > > Hi, Arnd
> > > 
> > > On 2016?12?01? 20:05, Arnd Bergmann wrote:
> > > > On Thursday, December 1, 2016 8:48:40 AM CET Zhangfei Gao wrote:
> > > >> +               hisi,reset-bits = <0x20 0x8             /* 0: i2c0 */
> > > >> +                                  0x20 0x10            /* 1: i2c1 */
> > > >> +                                  0x20 0x20            /* 2: i2c2 */
> > > >> +                                  0x20 0x8000000>;     /* 3: i2c6 */
> > > >> +       };
> > > >> +
> > > >> +Specifying reset lines connected to IP modules
> > > >> +==============================================
> > > >> +example:
> > > >> +
> > > >> +        i2c0: i2c at ..... {
> > > >> +                ...
> > > >> +               resets = <&iomcu_rst 0>;
> > > >> +                ...
> > > >> +        };
> > > > I don't really like this approach, since now the information is
> > > > in two places. Why not put the data into the reset specifier
> > > > directly when it is used?
> 
> From my point of view, with the binding above, all reset controller
> register/bit layout information is in a single place and can be easily
> compared to a list in the reference manual, whereas with your suggestion
> the description of the reset controller register layout is spread
> throughout one or even several dtsi files.

Which can be solved by tools.

> Also, since no two reset controllers are exactly the same, we get a
> proliferation of different slightly phandle argument meanings.

phandle args are supposed to be specific to the phandle it points to. 
Otherwise, we'd never need more than 1 cell and everything could be a 
lookup table.

> 
> > > Any example, still not understand.
> > > They are consumer and provider.
> > 
> > I mean in the i2c node, have
> > 
> > 	i2c0: i2c at ..... {
> > 		...
> > 		resets = <&iomcu_rst 0x20 0x8>;
> > 		...
> > 	}
> 
> There already are a few drivers that use this, and I fear people having
> to change their bindings because new flags are needed that have not been
> previously thought of.
> 

Drivers that use what?

Rob
