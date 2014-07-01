From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 1 Jul 2014 19:56:01 +0200
Subject: [PATCH 00/33] ARM: at91: Switch remaining SoCs and boards to CCF
In-Reply-To: <8196570.1BaMSL4giB@wuerfel>
References: <1404223962-30471-1-git-send-email-alexandre.belloni@free-electrons.com>
 <5780166.MMf0Vhnnsu@wuerfel> <20140701164851.GI3427@piout.net>
 <8196570.1BaMSL4giB@wuerfel>
Message-ID: <20140701175601.GJ3427@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/2014 at 19:01:12 +0200, Arnd Bergmann wrote :
> On Tuesday 01 July 2014 18:48:51 Alexandre Belloni wrote:
> > On 01/07/2014 at 18:35:50 +0200, Arnd Bergmann wrote :
> > > If I read this right, disabling 'USE_OF' results in still using
> > > the old clock interface. Is that intentional? If you want to always
> > > use COMMON_CLK now, the above can probably be simplified to
> > > 
> > > config AT91_PMC_UNIT
> > >         def_bool !ARCH_AT91X40
> > >       select COMMON_CLK
> > > 
> > > and all references to AT91_USE_OLD_CLK, COMMON_CLK_AT91 and
> > > OLD_CLK_AT91 be removed.
> > 
> > Yeah, this is intentional we still have 30 or so boards that we have to
> > migrate to DT. Until then, we want to be able to boot a kernel without
> > CCF. The next step in the migration is to switch those boards to DT,
> > possibly using an hybrid DT/pdata approach until we can get rid of the
> > board files. Then, we will be able to get rid of the old clk
> > implementation (and a few other drivers still living in mach-at91).
> 
> Ok, I see. Do you expect those 30 boards to work if COMMON_CLK_AT91
> is enabled, or are there known problems with that?
> 
> If you have reason to believe it doesn't work, maybe you can expose
> the selection of the clock interface to users, e.g. like
> 

We actually do the opposite, when a board without DT support is
selected, the old clock support is also selected even when also
selecting CONFIG_OF.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
