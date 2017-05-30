From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 May 2017 13:41:55 +0200
Subject: [PATCH 2/6] dt-bindings: interrupt-controller: add DT binding
 for the Marvell ICU
In-Reply-To: <97989700-2c97-892e-b470-a84af6dfd77b@arm.com>
References: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496135772-20694-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <97989700-2c97-892e-b470-a84af6dfd77b@arm.com>
Message-ID: <20170530134155.4996efdb@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Thanks for the quick review!

On Tue, 30 May 2017 11:37:10 +0100, Marc Zyngier wrote:

> > +  The 1st cell is the group type of the ICU interrupt (SPI_NSR,
> > +  SPI_SR, SEI, and REI).  
> 
> Is it worth documenting what these are?

Sure, will do.

> > +icu: interrupt-controller at 1e0000 {
> > +	compatible = "marvell,icu";
> > +	reg = <0x1e0000 0x10>;
> > +	#interrupt-cells = <2>;  
> 
> Oh wait...

Gaah, I did spot this mistake, but then forgot to fix it. Will do.

> > +	interrupt-controller;
> > +	interrupt-parent = <&gic>;
> > +	gicp = <&gicp>;  
> 
> Should this be prefixed with a vendor specific identifier, just in case?

Would marvell,gicp be preferable?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
