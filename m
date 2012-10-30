From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 30 Oct 2012 07:02:26 +0100
Subject: [PATCH] ARM: kirkwood: Increase NAND chip-delay for DNS-320
In-Reply-To: <alpine.DEB.2.00.1210292156240.10589@marmot.wormnet.eu>
References: <1351457262-11506-1-git-send-email-jm@lentin.co.uk>
 <20121028205956.GH15143@lunn.ch>
 <alpine.DEB.2.00.1210282123250.10589@marmot.wormnet.eu>
 <20121029064632.GJ15143@lunn.ch>
 <alpine.DEB.2.00.1210292156240.10589@marmot.wormnet.eu>
Message-ID: <20121030060226.GA14093@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >I'm currently downloading the GPL sources from dlink. If the kernel
> >sources are included, we can see how dlink sets this. If its also 35,
> >then there is no argument.
> 
> Rummaging myself, my best guess is:
> 
> linux-2.6.22.18/arch/arm/mach-feroceon-kw/nand.c
> 173:    this->chip_delay = 30;
> 
> u-boot-1.1.4/board/mv_feroceon/USP/mv_nand.c
> 68: nand->chip_delay = 30;
> 
> However, this is too fast for my NAS when using a mainline kernel.
> 31usecs seems to work though. It's probably worth noting that the
> original firmware wasn't without it's problems on this particular
> board---I couldn't get it to reflash the NAND with a new firmware
> image. It could certainly read the NAND though.
> 
> This chip_delay value seems to be there in both the DNS320 and
> DNS325 GPL source. Maybe increasing chip_delay for both would be
> safest.

Yep. Please could you submit a new patch for dnskw.dtsi.

I guess you are not the only person with problems with 30, so 35 seems
sensible.

Do you have any idea how much this affects performance? It might not
be worth the effort to probe the chip and set the timing, if its only
a couple of % difference.

  Andrew
