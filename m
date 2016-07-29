From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 29 Jul 2016 07:48:00 +0200
Subject: [PATCH 00/13] arm64: Allwinner A64 support based on sunxi-ng
In-Reply-To: <20160728200705.GG6682@lukather>
References: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
 <20160727104623.e9ca7b708e5c6462f44a5d01@free.fr>
 <20160728200705.GG6682@lukather>
Message-ID: <20160729074800.44b8860cc0a3d2dfcdde32ce@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Jul 2016 22:07:05 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> > > Let me know what you think,
> > 
> > I don't see the interest to have common code for 32bits and 64bits.
> > The clock driver of a SoC will never evolve, so, it is simpler to
> > copy the source common with the H3 into a clean A64 clock driver.
> 
> I'm not sure why 32 bits vs 64 bits matters here. We're going to share
> a significant number of drivers already between armv7 and armv8, like
> MMC, EMAC, I2C, and so on.
> 
> And I expect to share the data in other SoCs for the A10, A13 and A20
> for example, or A23/A33, which have a lot of clocks in common too.

The interest of your sunxi-ng approach is that the clocks of each SoC
is described in one file. Here you are mixing 2 SoCs in the same source
file. The advantage is lost.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
