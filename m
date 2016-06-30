From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 01 Jul 2016 00:50:06 +0200
Subject: [PATCH] arm64: dts: rockchip: add the power domain node for rk3399
In-Reply-To: <CAD=FV=Uaqp5MyERwBRd1yHLYS3T2mOm-FrMtXUjzjWhCEggG+Q@mail.gmail.com>
References: <1467251760-14695-1-git-send-email-wxt@rock-chips.com>
 <2709691.LCsUme3dJo@phil>
 <CAD=FV=Uaqp5MyERwBRd1yHLYS3T2mOm-FrMtXUjzjWhCEggG+Q@mail.gmail.com>
Message-ID: <2164835.qn3FrgoRRc@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 30. Juni 2016, 15:32:01 schrieb Doug Anderson:
> Hi,
> 
> On Thu, Jun 30, 2016 at 2:57 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> >> It looks like there are also more power domains that you haven't
> >> listed here (like PD_GMAC, for instance, or PD_CORE_L).  Are you
> >> planning to add those in a followon patch?
> > 
> > that reminds me, nodes with a reg property should have the base address
> > in the node name as well. Using the constant works nicely, as can be
> > seen on> 
> > the rk3288 where we have for example:
> >         pd_vio at RK3288_PD_VIO
> 
> I was wondering about that.  The device tree bindings are similarly
> missing the reg from the example.
> 
> I'm curious: for sorting purposes, are you supposed to know the
> underlying integer and use that for sorting, or sort by the name of
> the #define?

requiring the underlying integer sounds very cumbersome, especially as the 
sorting is only a style-thing. So personally I'd take the constants name as 
sorting criteria, as everything else would be somewhat counter-intuitive.

Heiko
