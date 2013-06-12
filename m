From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Jun 2013 13:20:21 +0200
Subject: [linux-sunxi] [PATCHv4 7/9] ARM: sun5i: dt: Add i2c muxing options
In-Reply-To: <1371025788.4659.20.camel@localhost>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
 <1371024438-16631-8-git-send-email-maxime.ripard@free-electrons.com>
 <1371025788.4659.20.camel@localhost>
Message-ID: <20130612112021.GC16699@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Henrik,

On Wed, Jun 12, 2013 at 10:29:48AM +0200, Henrik Nordstr?m wrote:
> ons 2013-06-12 klockan 10:07 +0200 skrev Maxime Ripard:
> 
> > +			i2c0_pins_a: i2c0 at 0 {
> > +				allwinner,pins = "PB0", "PB1";
> > +				allwinner,function = "i2c0";
> > +				allwinner,drive = <0>;
> > +				allwinner,pull = <0>;
> 
> Is this right? All other use pull = 1.

Ah, true.

> I guess it's board dependent depending on if there is external pullups
> or not on the i2c bus. I have seen Allwinner designs both with and
> without external pullups.
> 
> It will not work well if there is neither internal or external pullup.
> And may stress the i2c components a bit if there is both..

Yes, but it's a default, so by definition, it won't suit everyone. Yet,
it has to be there. And every board is free to override that default in
its own DT anyway, so it's not really a big issue. But like you pointed
at, we have to be consistent.

I'll disable the pull-ups in the next iteration for every node.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
