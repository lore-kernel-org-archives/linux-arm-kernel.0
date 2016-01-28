From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 28 Jan 2016 15:55:14 +0100
Subject: [PATCH RFC 1/2] clk: sunxi: Add sun8i display support
In-Reply-To: <20160127215051.GW4317@lukather>
References: <cover.1452021349.git.moinejf@free.fr>
 <9cc33c3701844a07c43ee6c0c1072be4e2073cc1.1452021349.git.moinejf@free.fr>
 <20160118190904.GP4581@lukather>
 <20160119090901.17c64bc4afb7095bb8bd291c@free.fr>
 <20160127215051.GW4317@lukather>
Message-ID: <20160128155514.41dbf9cbf37d5e25775c51a2@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Jan 2016 22:50:51 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Hi,
> 
> On Tue, Jan 19, 2016 at 09:09:01AM +0100, Jean-Francois Moine wrote:
> > On Mon, 18 Jan 2016 20:09:04 +0100
> > Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
	[snip]
> > > We have the clk-factors stuff to handle this easily, could you use
> > > that instead ?
> > 
> > No, the sun6i/8i pll3 offers direct 297MHz and 270MHz.
> 
> That's true, but so far it's something that never has been really
> needed. This PLL is not the same one using the fractional mode, so I
> guess we could extend the clk-factors to be able to deal with
> that. The video pll in the A10 (pll3) is also in this case, so does
> the A31 PLL3 and PLL4.
> 
> Also note that all these clocks can reach those frequencies through
> what allwinner calls the integer mode, so apart from the hardware
> readout, we don't really need it anyway.

Maybe it is too simple! 297MHz is the PLL3 frequency which can be used
for most video modes. And, so, as it is the default value, in my tests,
I never saw the PLL3 set_rate function being called.

	[snip]
> > Otherwise, about this old RFC, Chen-Yu Tsai replied:
> > 
> > > > Add the clock types which are used by the sun8i family for video.
> > > 
> > > These clocks first appeared in the A31.
> 
> The video PLL is, the display engine and tcon clocks are a bit
> different (mostly because of their weird parent configuration that
> need a muxing table). Note that I'm talking about the A23 / A33. I
> haven't checked for the H3.

The TCONs of the A23/A33 and H3 SoCs are quite the same.
The display engines 2 of the H3/A64/A83T are the same and they ask for
a fixed clock (432MHz).

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
