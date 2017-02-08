From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Feb 2017 11:52:59 +0100
Subject: [PATCH 4/4] clk: mvebu: Expand mv98dx3236-core-clock support
In-Reply-To: <6149d4126a214ac8b0b0184bd818bea6@svr-chch-ex1.atlnz.lc>
References: <20170203034012.29399-1-chris.packham@alliedtelesis.co.nz>
 <5a974d9d7260432087619486bf5d79ed@svr-chch-ex1.atlnz.lc>
 <6149d4126a214ac8b0b0184bd818bea6@svr-chch-ex1.atlnz.lc>
Message-ID: <9294933.cXSW0amFbE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, February 7, 2017 3:07:37 AM CET Chris Packham wrote:
> >
> > Actually I wonder if I can try a bit harder to keep a system booting.
> > The following might work
> > 1) add the compatible strings to the existing armada clock drivers.
> > 2) update the dts to use the new compatible strings.
> > 3) add the new driver and remove the compatible strings from the armada
> > drivers.
> >
> > #1 would still upset checkpatch.pl because the documentation would only
> > arrive in #2.
> 
> Actually upon testing #1 is unnecessary. I lose some of the gated clocks 
> but nothing that prevents booting.

Just to be sure: this means we can merge 2) and 3) independently and
having just one of them will not cause regressions over what we have
today?

	Arnd
