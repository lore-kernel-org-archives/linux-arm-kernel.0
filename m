From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 24 Apr 2017 12:35:39 +0200
Subject: [PATCH] arm64: dts: rockchip: update cpu opp table for rk3399 op1
In-Reply-To: <9edc6ebc-8aab-03df-49b2-759ed8581a6c@163.com>
References: <1493014730-9670-1-git-send-email-wxt@rock-chips.com>
 <3119382.DFiP2J6FnE@diego> <9edc6ebc-8aab-03df-49b2-759ed8581a6c@163.com>
Message-ID: <1552813.CRZkXFJCNX@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 24. April 2017, 18:25:49 CEST schrieb Caesar Wang:
> ? 2017?04?24? 17:15, Heiko St?bner ??:
> > Am Montag, 24. April 2017, 16:49:08 CEST schrieb Caesar Wang:
> >> ? 2017?04?24? 16:26, Heiko St?bner ??:
> >>> Hi Caesar,
> >>> 
> >>> Am Montag, 24. April 2017, 14:18:50 CEST schrieb Caesar Wang:
> >>>> Update the cpu opp table for rk3399 op1.
> >>> 
> >>> Ideally this should contain something about the "why".
> >>> Are these new voltage settings safer to operate under?
> >> 
> >> The before opp table is for earlier batch of rk3399 SoCs,  that's no
> >> enough for the current and
> >> newer batch of rk3399 op1. In order to suit for the rk3399 op1, we need
> >> to little voltages changed.
> > 
> > just to make sure, this is also safe for all the non-chromebook rk3399
> > socs
> > (like the firefly and tv-boxes, etc), right?
> 
> No,  just for chromebook.
> 
> Maybe, we need support two table for rk3399 SoCs.
> For chromebook supporting 2GHz frequency and others support 1.8GHz
> frequency.

Definitly. So please move the chromebook opp-table to something like a rk3399-
op1-opp.dtsi and adapt rk3399-opp.dtsi to be safe for all rk3399 variants.


Thanks
Heiko

> 
> For example:
> ....
>    opp03 {
>                opp-hz = /bits/ 64 <1008000000>;
>                opp-microvolt = <925000 925000 1350000>;
>                opp-microvolt-l0 = <925000 925000 1350000>;
>                opp-microvolt-l1 = <900000 900000 1350000>;
>            };
> ....
> 
> 
> 
> -Caesar
> 
> > Thanks
> > Heiko
> > 
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
