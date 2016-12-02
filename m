From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 02 Dec 2016 15:10:13 +0100
Subject: [resend v2: PATCH 1/2] dt-bindings: Document the hi3660 reset
 bindings
In-Reply-To: <5982682.vMJxVociDa@wuerfel>
References: <1480553321-17400-1-git-send-email-zhangfei.gao@linaro.org>
 <3900806.3NUubBDb0Q@wuerfel>
 <e15e76e2-b32d-a4d0-eb8b-850626a3946a@linaro.org>
 <5982682.vMJxVociDa@wuerfel>
Message-ID: <1480687813.2460.19.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 02.12.2016, 13:32 +0100 schrieb Arnd Bergmann:
> On Friday, December 2, 2016 8:21:33 AM CET zhangfei wrote:
> > Hi, Arnd
> > 
> > On 2016?12?01? 20:05, Arnd Bergmann wrote:
> > > On Thursday, December 1, 2016 8:48:40 AM CET Zhangfei Gao wrote:
> > >> +               hisi,reset-bits = <0x20 0x8             /* 0: i2c0 */
> > >> +                                  0x20 0x10            /* 1: i2c1 */
> > >> +                                  0x20 0x20            /* 2: i2c2 */
> > >> +                                  0x20 0x8000000>;     /* 3: i2c6 */
> > >> +       };
> > >> +
> > >> +Specifying reset lines connected to IP modules
> > >> +==============================================
> > >> +example:
> > >> +
> > >> +        i2c0: i2c at ..... {
> > >> +                ...
> > >> +               resets = <&iomcu_rst 0>;
> > >> +                ...
> > >> +        };
> > > I don't really like this approach, since now the information is
> > > in two places. Why not put the data into the reset specifier
> > > directly when it is used?

>From my point of view, with the binding above, all reset controller
register/bit layout information is in a single place and can be easily
compared to a list in the reference manual, whereas with your suggestion
the description of the reset controller register layout is spread
throughout one or even several dtsi files.
Also, since no two reset controllers are exactly the same, we get a
proliferation of different slightly phandle argument meanings.

> > Any example, still not understand.
> > They are consumer and provider.
> 
> I mean in the i2c node, have
> 
> 	i2c0: i2c at ..... {
> 		...
> 		resets = <&iomcu_rst 0x20 0x8>;
> 		...
> 	}

There already are a few drivers that use this, and I fear people having
to change their bindings because new flags are needed that have not been
previously thought of.

regards
Philipp
