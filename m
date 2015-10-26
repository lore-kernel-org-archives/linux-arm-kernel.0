From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 Oct 2015 09:40:34 +0900
Subject: [GIT PULL] Allwinner DT changes for 4.4, round 3
In-Reply-To: <9946613.K7Ehp1DEiL@wuerfel>
References: <20151023180711.GA11749@lukather> <4745252.gLSrJNQ42D@wuerfel>
 <9946613.K7Ehp1DEiL@wuerfel>
Message-ID: <20151026004034.GA14238@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 10:55:13PM +0200, Arnd Bergmann wrote:
> On Friday 23 October 2015 22:41:04 Arnd Bergmann wrote:
> > On Friday 23 October 2015 20:07:11 Maxime Ripard wrote:
> > > Allwinner DT changes for 4.4, round 3
> > > 
> > > A bunch of new boards, but mostly enable the support for the Audio Codec
> > > on the older SoCs (A10, A10s, A13, A20, R8) and enable it on various
> > > boards.
> > > 
> > > 
> > 
> > Pulled into next/dt, thanks!
> 
> And dropped again:
> 
> In file included from /git/arm-soc/arch/arm/boot/dts/sun4i-a10-a1000.dts:46:0:
> /git/arm-soc/arch/arm/boot/dts/sun4i-a10.dtsi:48:46: fatal error: dt-bindings/clock/sun4i-a10-pll2.h: No such file or directory

I'm starting to find these header files somewhat tedious to deal with,
and I wish we could do it better. We're creating a lot of cross-tree
dependencies with these, usually jsut for one or two added lines in one
of these headers.

For those cases, I wonder if we should just take the DT change without using
the symbol for the first release, and then next release a cleanup patch that
moves over to include the header file and use that flag from there.

But I'm all ears looking for better suggestions too. I wish to move away from
the current model where we usually have to merge in a clk or pinctrl branch to
get this though.


-Olof
