From: tony@atomide.com (Tony Lindgren)
Date: Tue, 10 Dec 2013 10:59:02 -0800
Subject: [GIT PULL] make mach-omap2 boot with device tree only for v3.14
In-Reply-To: <alpine.DEB.2.02.1312101034360.32309@utopia.booyaka.com>
References: <pull-1386643347-596413>
 <alpine.DEB.2.02.1312101034360.32309@utopia.booyaka.com>
Message-ID: <20131210185902.GO13171@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [131210 10:47]:
> On Mon, 9 Dec 2013, Tony Lindgren wrote:
> 
> > The following changes since commit f2e2c9d9b4087b74eb9e00d8dfac148354cb0b71:
> > 
> >   ARM: dts: Fix booting for secure omaps (2013-12-06 15:30:43 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/omap3-board-removal-signed
> > 
> > for you to fetch changes up to 736e812636ea72be444b85fa7e92554967459069:
> > 
> >   ARM: OMAP2+: Remove unused platform init code and headers (2013-12-08 14:15:46 -0800)
> 
> The description in Tony's pull request below alludes to what regressions 
> will occur when this is pulled.  But just to state it in terms of what 
> happened on the local testbed here when I tried it:
> 
> - CM-T3517 booting will break since there's no .dts file for it.  Are
>   there other boards that will be affected here too?

Yeah the cm-t3770 is on my todo list, but I've left it last as it's my
home router and has been behaving quite nicely.

That should then cover:

SBC-T3530
http://compulab.co.il/products/sbcs/sbc-t3530/

SBC-T3517
http://compulab.co.il/products/sbcs/sbc-t3517/

SBC-T3730
http://compulab.co.il/products/sbcs/sbc-t3730/

They all seem to have the same baseboard, and the CPU module is
different. So getting the 3530 and 3517 variants working should
be trivial. I don't have 3530 or 3517 variants, so somebody else
will need to do those two.

And Nishant just posted a .dts file for the 3517 craneboard.
  
> - 2430SDP NFS root will hang during boot, presumably due to the lack 
>   of the smc91x patch that is mentioned below

Yes that's correct, hopefully we'll have that in v3.13.
 
> - Dynamic idle PM tests will fail, due to the lack of the first two 
>   patches that Tony mentioned.  (This is also a problem now for
>   37xxevm in v3.13-rc.)

Yes that's something that should be fixes for v3.13 as well.
 
> - The N800 isn't booting here with a concatenated uImage+dtb - but
>   maybe I'm doing something wrong with this one.

Hmm n800 works for me here for sure, I can n-uple check today.
 
> Best if the pull request were to explicitly state the known 
> regressions with this series, in terms of specific boards and 
> configurations.  That way, people will know what to expect.

Well ideally we would have no regressions when doing this, but I've
been chasing people and bugs for few years now on this DT conversion
and we still always find something. In most cases it should be just
a question of configuring a board specific .dts file. I don't have
all the boards though, so I've only done the ones I have naturally.

Regards,

Tony
