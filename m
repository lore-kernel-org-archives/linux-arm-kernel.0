From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri, 13 Jan 2017 12:36:47 +0800
Subject: [PATCH 2/5] clk: sunxi-ng: add support for V3s CCU
In-Reply-To: <20170112174122.iqzrcyytfefqspwq@lukather>
References: <20170112203149.VhtuR9dM@smtp3j.mail.yandex.net>
 <20170112174122.iqzrcyytfefqspwq@lukather>
Message-ID: <895011484282207@web8g.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



13.01.2017, 01:41, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> On Fri, Jan 13, 2017 at 01:31:41AM +0800, Icenowy Zheng wrote:
>> ?2017?1?13? 01:19? Maxime Ripard <maxime.ripard@free-electrons.com>???
>> ?>
>> ?> On Thu, Jan 12, 2017 at 03:44:53AM +0800, Icenowy Zheng wrote:
>> ?> >
>> ?> >
>> ?> > 12.01.2017, 03:40, "Icenowy Zheng" <icenowy@aosc.xyz>:
>> ?> > > 11.01.2017, 02:10, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
>> ?> > >> ?On Tue, Jan 03, 2017 at 11:16:26PM +0800, Icenowy Zheng wrote:
>> ?> > >>> ??V3s has a similar but cut-down CCU to H3.
>> ?> > >>>
>> ?> > >>> ??Add support for it.
>> ?> > >>>
>> ?> > >>> ??Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> ?> > >>
>> ?> > >> ?It looks like there's nothing different but the clocks that you
>> ?> > >> ?register with the H3, please just use the H3 driver.
>> ?> > >
>> ?> > > Nope.
>> ?> > >
>> ?> > > It has a different PLL (PLL_ISP) at different address, and some
>> ?> > > different muxes.
>> ?> >
>> ?> > Forgot to mention the missing of PLL_DE and related misses.
>> ?>
>> ?> Those are not conflicting, it's just a slightly different set of
>> ?> clocks.
>>
>> ?If saying so, we can have only one ccu driver, and make every ccu
>> ?register different set ;-)
>>
>> ?V3s itself is a totally different SoC with H3.
>>
>> ?The relationship of V3s and H3 can be farther than the relationship
>> ?of A33 and H3?
>
> A33 and H3 are an entirely different story. The H3 and A33 have
> conflicting clocks (ie same clocks with different parameters). This is
> not your case.

I think V3s and H3 has also conflicting clocks, e.g. CLK_DE.

The mux of CLK_DE in V3s is PLL_PERIPHx2 and PLL_VIDEO, but on H3
it's PLL_PERIPHx2 and PLL_DE (V3s lacks PLL_DE).

(What I say that there's a PLL missing means that there will also be mux
changes... I think you can understand this... sorry.)

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
