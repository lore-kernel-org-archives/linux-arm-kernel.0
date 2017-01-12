From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 12 Jan 2017 18:41:23 +0100
Subject: [PATCH 2/5] clk: sunxi-ng: add support for V3s CCU
In-Reply-To: <20170112203149.VhtuR9dM@smtp3j.mail.yandex.net>
References: <20170112203149.VhtuR9dM@smtp3j.mail.yandex.net>
Message-ID: <20170112174122.iqzrcyytfefqspwq@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 01:31:41AM +0800, Icenowy Zheng wrote:
> 
> 2017?1?13? 01:19? Maxime Ripard <maxime.ripard@free-electrons.com>???
> >
> > On Thu, Jan 12, 2017 at 03:44:53AM +0800, Icenowy Zheng wrote: 
> > > 
> > > 
> > > 12.01.2017, 03:40, "Icenowy Zheng" <icenowy@aosc.xyz>: 
> > > > 11.01.2017, 02:10, "Maxime Ripard" <maxime.ripard@free-electrons.com>: 
> > > >> ?On Tue, Jan 03, 2017 at 11:16:26PM +0800, Icenowy Zheng wrote: 
> > > >>> ??V3s has a similar but cut-down CCU to H3. 
> > > >>> 
> > > >>> ??Add support for it. 
> > > >>> 
> > > >>> ??Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz> 
> > > >> 
> > > >> ?It looks like there's nothing different but the clocks that you 
> > > >> ?register with the H3, please just use the H3 driver. 
> > > > 
> > > > Nope. 
> > > > 
> > > > It has a different PLL (PLL_ISP) at different address, and some 
> > > > different muxes. 
> > > 
> > > Forgot to mention the missing of PLL_DE and related misses. 
> >
> > Those are not conflicting, it's just a slightly different set of 
> > clocks. 
> 
> If saying so, we can have only one ccu driver, and make every ccu
> register different set ;-)
> 
> V3s itself is a totally different SoC with H3.
> 
> The relationship of V3s and H3 can be farther than the relationship
> of A33 and H3?

A33 and H3 are an entirely different story. The H3 and A33 have
conflicting clocks (ie same clocks with different parameters). This is
not your case.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170112/8631d007/attachment.sig>
