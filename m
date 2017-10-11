From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 11 Oct 2017 17:44:54 +1030
Subject: [PATCH 11/11] ARM: dts: Add PCLK to the Aspeed watchdogs
In-Reply-To: <CACRpkdYQ8WE_-nVza=GnNBvfXV=WpcEipoJhVVn=atcqyQZbpw@mail.gmail.com>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-12-linus.walleij@linaro.org>
 <1507693686.5452.174.camel@aj.id.au>
 <CACRpkdYQ8WE_-nVza=GnNBvfXV=WpcEipoJhVVn=atcqyQZbpw@mail.gmail.com>
Message-ID: <1507706094.5452.181.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-10-11 at 08:32 +0200, Linus Walleij wrote:
> > On Wed, Oct 11, 2017 at 5:48 AM, Andrew Jeffery <andrew@aj.id.au> wrote:
> > On Sat, 2017-08-12 at 20:43 +0200, Linus Walleij wrote:
> > > This adds the PCLK clock to the Aspeed watchdog blocks.
> > > I am not directly familiar with the Aspeed clocking, but
> > > since the IP is derived from Faraday FTWDT010 it probably
> > > has the ability to run the watchdog on the PCLK if
> > > desired
> > 
> > This is true for the AST2400, but not the AST2500 where the only option
> > is EXTCLK (1MHz).
> 
> The IP block/cell certainly has a PCLK even if it cannot be used
> to drive the watchdog timer. It is necessary to interface the
> SoC interconnect.

Hah, yep, brain-fade.

Cheers,

Andrew

> 
> > > > +???????????????????????????clocks = <&clk_apb>;
> > > 
> > > +?????????????????????????????clock-names = "PCLK";
> > 
> > Given the comment above, shouldn't we be doing something like the
> > following instead for each of the watchdogs?
> > 
> > +???????????????????????????????faraday,use-extclk;
> > +???????????????????????????????clock-names = "EXTCLK";
> 
> So that will be added too, later, when there is a 1MHz clock
> to reference in the device tree. I guess after Joel's patches.
> 
> Yours,
> Linus Walleij
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171011/d867a068/attachment-0001.sig>
