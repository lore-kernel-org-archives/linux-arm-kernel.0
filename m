From: olof@lixom.net (Olof Johansson)
Date: Sun, 2 Jun 2013 20:27:11 -0700
Subject: [PATCH 08/10] clk: add basic Rockchip rk3066a clock support
In-Reply-To: <201306030100.31647.heiko@sntech.de>
References: <201306030055.15413.heiko@sntech.de>
 <201306030100.31647.heiko@sntech.de>
Message-ID: <20130603032711.GA3379@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 01:00:31AM +0200, Heiko St?bner wrote:
> This adds basic support for clocks on Rockchip rk3066 SoCs.
> The clock handling thru small dt nodes is heavily inspired by the
> sunxi clk code.
> 
> The clock specifiers are named as "x-cortex-a9-x", because the clock
> semantics are the same thru the whole cortex-a9 series (rk30xx,
> rk3188, rk2928; but not the other rk29 SoCs, which are Cortex-A8 based).

Hi,

I think you're better off naming them after the first SoC of that series.
Otherwise, if there's an A9-based platform in the future that is not
compatible, things will get complicated.

It's pretty common that we do this for other kinds of devices, so it seems
appropriate for clock drivers too.


-Olof
