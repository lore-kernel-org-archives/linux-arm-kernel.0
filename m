From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 10 May 2017 15:55:37 +0200
Subject: [PATCH 3/4] ARM: dts: rockchip: use pin constants to describe IO
 in pinctrl
In-Reply-To: <c98e2eaf-3e92-a6b6-5367-df31d0614d5c@rock-chips.com>
References: <1491981044-24635-1-git-send-email-kever.yang@rock-chips.com>
 <3966386.YQGqDXjHSp@phil>
 <c98e2eaf-3e92-a6b6-5367-df31d0614d5c@rock-chips.com>
Message-ID: <3502373.tsXPg1D3p7@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kever,

Am Mittwoch, 10. Mai 2017, 09:25:25 CEST schrieb Kever Yang:
> On 05/10/2017 05:43 AM, Heiko Stuebner wrote:
> > Am Mittwoch, 12. April 2017, 15:10:43 CEST schrieb Kever Yang:
> >> Use command below to replace the IO naming in pinctrl:
> >> sed -i -e 's/ 31 RK_FUNC_/ RK_PD7 RK_FUNC_/' arch/arm/boot/dts/rk*
> >> sed -i -e 's/ 0 RK_FUNC_/ RK_PA0 RK_FUNC_/'
> >> arch/arm64/boot/dts/rockchip/*
> >>
> >> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> > I'm not sure, if we really want to mass-convert each and every pin.
> > All pins in use right now seem to be working and it hides other
> > history/blame for these entries.
> 
> Do you mean you want to leave the code already there as is, and new
> code using MACRO define for IO?
> 
> This sounds reasonable, I can agree on this. I send this patch because I 
> see there is
> a patch from Andy using MACRO for many IOs, but not complete enough
> and my patch suppose to make all Rockchip IO has update.

As I said, I'm really not sure. On the one hand it's nicer and it will
be easier to check devicetree against schematics, but mass-converting
them makes me anxious. Andy did convert the rk3288-popmetal
board which is somewhat sparsely used I think. If anything breaks with
Firefly, Rock, Veyron etc we might make a lot of people unhappy :-) .

But having boards use both paradigms at the same time (pin number and
names) could also be confusing.

> > In any case though, this needs to be split into separate arm32/arm64
> > patches.

Maybe we could split not only on the arm/arm64 border, but also on
something like soc-level (rk3188, rk3288, rk3368). That way the amount
of changes per patch would go down making review easier :-) .


Just to make sure you saw it, I've also had to drop patch2 again (see
separate response from yesterday).


Heiko
