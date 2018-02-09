From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 09 Feb 2018 10:24:01 +0100
Subject: [2/9] phy: add Rockchip Innosilicon hdmi phy
In-Reply-To: <alpine.GSO.2.00.1802052159530.23549@dmz.c-home.cz>
References: <20180205143435.4723-3-heiko@sntech.de>
 <alpine.GSO.2.00.1802052159530.23549@dmz.c-home.cz>
Message-ID: <2860925.eKDKvHpOYg@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

Am Montag, 5. Februar 2018, 22:32:08 CET schrieb Martin Cerveny:
> On Mon, 5 Feb 2018, Heiko Stuebner wrote:
> > From: Zheng Yang <zhengyang@rock-chips.com>
> >
> > Add a driver for the Innosilicon hdmi phy used on rk3228/rk3229
> > and rk3328 socs from Rockchip.
> >
> > Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > +++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
> > +static u32 inno_hdmi_phy_get_tmdsclk(struct inno_hdmi_phy *inno, int rate)
> > +{
> > +	int bus_width = phy_get_bus_width(inno->phy);
> > +	u32 tmdsclk;
> > +
> > +	switch (bus_width) {
> > +	case 4:
> > +		tmdsclk = rate / 2;
> > +		break;
> > +	case 5:
> > +		tmdsclk = rate * 5 / 8;
> > +		break;
> > +	case 6:
> > +		tmdsclk = rate * 3 / 4;
> > +		break;
> > +	case 10:
> > +		tmdsclk = rate * 5 / 4;
> > +		break;
> > +	case 12:
> > +		tmdsclk = rate * 3 / 2;
> > +		break;
> > +	case 16:
> > +		tmdsclk = rate * 2;
> > +		break;
> > +	default:
> > +		tmdsclk = rate;
> > +	}
> > +
> > +	return tmdsclk;
> > +}
> 
> Please corrects integer overflow 
> like https://github.com/mcerveny/rockchip-linux/commit/b4bc703f2dca4e5115b22155920d2277671a9f00

thanks for finding that possible issue. I've adapted the phy driver
in a similar way (using u64 though) and will include that change in the
next version.


Thanks
Heiko
