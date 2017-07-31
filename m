From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Mon, 31 Jul 2017 18:50:11 +0200
Subject: [linux-sunxi] Re: [PATCH 0/4] clk: sunxi-ng: Fix issues with
 fractional mode
In-Reply-To: <CAGb2v65pH-Me6JjMYzp41NwS478azMTLBPrkJwZcho9Ay2JX1Q@mail.gmail.com>
References: <20170730164150.26302-1-jernej.skrabec@siol.net>
 <CAGb2v65pH-Me6JjMYzp41NwS478azMTLBPrkJwZcho9Ay2JX1Q@mail.gmail.com>
Message-ID: <4026156.d8uMWWFJnt@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

Dne ponedeljek, 31. julij 2017 ob 07:13:34 CEST je Chen-Yu Tsai napisal(a):
> Hi Jernej,
> 
> On Mon, Jul 31, 2017 at 12:41 AM, Jernej Skrabec
> 
> <jernej.skrabec@siol.net> wrote:
> > During development of H3 HDMI driver, I found some issues with
> > setting video clock rate. It turned out that clock driver decided
> > to use fractional mode and selected right frequency, but it didn't
> > enable it. Additionally, fractional helpers don't wait on lock.
> 
> What kind of resolution were you testing to actually hit this?

1920x1080p @ 60Hz

> 
> AFAIK the fractional mode is either 297 or 270 MHz. Even Full HD
> 1080p60 dot clocks aren't that high. And the clk drivers should
> try to request a matching parent clk rate. So the PLL wouldn't
> go that high. Are you testing 4k @ 30fps?

No, it is a bit more complicated than that. H3's HDMI PHY is proprietary and 
register meanings are not known well. Because of that, I'm using values found 
in BSP driver. Those values include pixel clock divider. BSP driver always use 
297 MHz as a base and uses dividers in PHY to prepare right pixel clock. So 
the case for 1080p is 297 MHz / 2 = 148.5 MHz.

> 
> As it stands, I don't think any of the existing display support
> can go that high, so I think we're safe as far as old kernels
> go, i.e. we don't need to Cc stable for these.

Ok.

Regards,
Jernej
