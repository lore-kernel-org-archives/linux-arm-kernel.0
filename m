From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Tue, 23 May 2017 18:11:28 +0200
Subject: [PATCH 00/13] Linksys WRT3200ACM (Rango) support
In-Reply-To: <87mva3wqci.fsf@free-electrons.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
 <87mva3wqci.fsf@free-electrons.com>
Message-ID: <20170523181128.43bd1f96@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 May 2017 17:22:05 +0200
Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Ralph,
>  
>  On dim., mai 21 2017, Ralph Sennhauser <ralph.sennhauser@gmail.com>
> wrote:
> 
> > Hi everyone
> >
> > This series adds support for the latest model in Linksys WRT AC
> > series of routers. The WRT3200ACM was released in October 2016 and
> > the code name is Rango.
> >
> > As it comes with a flash chip twice as big the dts Imre Kaloz has
> > written for OpenWrt isn't based on armada-385-linksys.dtsi to avoid
> > conflicts. Nonetheless its part of the same family, so the bigger
> > part of this series is dedicated to reorganize / modernize /
> > cleanup / somewhat future proof the armada-385-linksys.dtsi and
> > it's dependants so the dts for the Rango addition can use the same
> > dtsi.
> >
> > Key differences to the earlier Armada-385 based devices in the
> > series is a bigger flash chip, next generation wireless modules in
> > the mini pcie slots as well as a Marvell SD8887. Finally the CPU is
> > clocked at 1866 GHz by default.
> >
> > The series depends on Linux 4.12-rc1 and is targeted for 4.13.
> >
> > Ralph
> >
> >  
> 

Hi Gregory,

> I applied the 11 first patches on mvebu/dt. I added the
> "Signed-off-by" from Imre Kaloz <kaloz@openwrt.org> on all of them
> and the "Reviewed-by" from Andrew Lunn <andrew@lunn.ch> when
> approriate.

That was a lot faster than expected

> 
> I also did the following things:
> 
> > Ralph Sennhauser (13):
> >   ARM: dts: armada-385-linksys: flatten dtsi

Just noticed the commit message has "helps helps" in it.

> >   ARM: dts: armada-385-linksys: label nodes  
> Fixed typo pointed by Andrew
> 
> >   ARM: dts: armada-385-linksys: flatten dependants  
> Fixed typo pointed by Andrew
> 
> Something that I didn't change is the word "dependants", I don't know
> what do you means exactly. But not being native speaker I maybe missed
> something.

Dependants is the noun, tho that might be a British English thing (what
I had in school). I learned English as 4th/5th language together with
Latin, so beside being a mixture of American and British English some
custom English surfaces from time to time. :)

> 
> >   ARM: dts: armada-385-linksys: drop redundant properties in
> > dependants ARM: dts: armada-385-linksys: bm pools by label order
> >   ARM: dts: armada-385-linksys: usb3 label cleanup  
> 
> I applied this one because I found Ralph explanation convincing about
> not modifying the ABI
> 
> >   ARM: dts: armada-385-linksys: drop leagcy DSA bindings  
> Fixed typo in title and commit log
> 

Didn't notice until you pointed it out. Thanks.

> >   ARM: dts: armada-385-linksys: use binary unit prefixes  
> 
> As Ralph I prefer that we use normalized unit. Especially when we use
> MiB or KiB then we are sure that we use a power of 2, whereas when we
> see KB we don't know if it is 1024B or 1000B.
> 
> >   ARM: dts: armada-385-linksys: partition layout is board specific
> >   ARM: dts: armada-385-linksys: group pins in pinctrl
> >   ARM: dts: armada-385-linksys: fixup button node names  
> 
> >   clk: mvebu: add support for 1866MHz variants  
> 
> I didn't apply this one as it must go through the clk tree and there
> was also a pending question from Andrew.

And the way he formulated it he probably already knows that more is
needed. I'll investigate it.

> 
> >   ARM: dts: mvebu: add support for Linksys WRT3200ACM (Rango)  
> 
> For this last one do you finally agree to use "non-removable" instead
> of "broken-cd" ?

The card isn't really accessible and as such polling sort of pointless.
I prefer non-removable but left it as-is for V1.

Thanks
Ralph

PS: Also thanks for applying the reminder of the pwm-fan series.
