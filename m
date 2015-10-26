From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 26 Oct 2015 11:34:09 +0100
Subject: [GIT PULL] Allwinner DT changes for 4.4, round 3
In-Reply-To: <20151026054828.GD4216@localhost>
References: <20151023180711.GA11749@lukather> <4745252.gLSrJNQ42D@wuerfel>
 <9946613.K7Ehp1DEiL@wuerfel> <20151025201308.GS10947@lukather>
 <20151026010752.GG14238@localhost>
 <CAGb2v671MmpRHkWKpOd8kmEbvfTKTU9k7AU_bP+AgRuguodWkQ@mail.gmail.com>
 <20151026054828.GD4216@localhost>
Message-ID: <20151026103409.GX10947@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 02:48:28PM +0900, Olof Johansson wrote:
> On Mon, Oct 26, 2015 at 09:46:24AM +0800, Chen-Yu Tsai wrote:
> > Hi Olof,
> > 
> > On Mon, Oct 26, 2015 at 9:07 AM, Olof Johansson <olof@lixom.net> wrote:
> > > On Sun, Oct 25, 2015 at 09:13:08PM +0100, Maxime Ripard wrote:
> > >> On Fri, Oct 23, 2015 at 10:55:13PM +0200, Arnd Bergmann wrote:
> > >> > On Friday 23 October 2015 22:41:04 Arnd Bergmann wrote:
> > >> > > On Friday 23 October 2015 20:07:11 Maxime Ripard wrote:
> > >> > > > Allwinner DT changes for 4.4, round 3
> > >> > > >
> > >> > > > A bunch of new boards, but mostly enable the support for the Audio Codec
> > >> > > > on the older SoCs (A10, A10s, A13, A20, R8) and enable it on various
> > >> > > > boards.
> > >> > > >
> > >> > > >
> > >> > >
> > >> > > Pulled into next/dt, thanks!
> > >> >
> > >> > And dropped again:
> > >> >
> > >> > In file included from /git/arm-soc/arch/arm/boot/dts/sun4i-a10-a1000.dts:46:0:
> > >> > /git/arm-soc/arch/arm/boot/dts/sun4i-a10.dtsi:48:46: fatal error: dt-bindings/clock/sun4i-a10-pll2.h: No such file or directory
> > >> >
> > >> > Please make sure branches you send actually work by themselves.
> > >>
> > >> Damn, you're right... Sorry about that...
> > >>
> > >> You need to pull the tag sunxi-clk-for-4.4 that has been merged in the
> > >> clk tree in 38ce30e29dc.
> > >>
> > >> Mike, Stephen, will that tag be stable?
> > >
> > > I don't see that tag in your tree, Maxime? I also don't see 38ce30e29dc in
> > > the clk tree on kernel.org.
> > >
> > > I'm a little confused right now...
> > 
> > The tag is "sunxi-clocks-for-4.4":
> >     https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/tag/?h=sunxi-clocks-for-4.4
> > 
> > The merge commit in the clk tree is 938ce30e29dc:
> >     https://git.kernel.org/cgit/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=938ce30e29dc
> 
> Thanks, so both the tag and the hash were missing a few characters. :-)

Gaah, sorry...

> I've merged this in now. Note that this has resulted in a tree that won't
> misect cleanly, since having the clk contents merged instead of used as a base
> for the dt branch means that you could end up in a bisect state that has the DT
> branch but not the clk branch.

Even if it has been merged before the DT patches have been applied?
That's not really what I'd expect from bisect :/

> These are some of the reasons why I'm not overly excited about these
> header file dependencies. :(

Yeah, I see why now. Your suggestion of using the raw values first and
then switch to using the headers make sense I guess, we'll try to
stick to that in the future.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151026/9df02597/attachment.sig>
