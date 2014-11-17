From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 17 Nov 2014 15:18:39 +0100
Subject: mvebu: tclk detection for armada-xp and marvell packet processor
 with integrated CPU
In-Reply-To: <20141117093437.0ca5a3ef@free-electrons.com>
References: <546959A3.9040206@alliedtelesis.co.nz>
 <20141117093437.0ca5a3ef@free-electrons.com>
Message-ID: <20141117141839.GM2001@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 09:34:37AM +0100, Thomas Petazzoni wrote:
> Dear Chris Packham,
> 
> On Mon, 17 Nov 2014 02:12:51 +0000, Chris Packham wrote:
> 
> > One of the first problems I encountered looking at the Marvell Packet 
> > Processor with integrated CPU (I'll refer to that as 'the PP' throughout 
> > the rest of this email) was that it has a different TCLK to the armada-xp.
> > 
> > It appears that for both the PP and the armada-xp the TCLK is hard-coded 
> > (to 200MHz and 250MHz respectively) and cannot be detected as far as I 
> > can see from the various data-sheets. I was hoping to re-use 
> > drivers/clk/mvebu/armada-xp.c but I need to figure out how to make 
> > axp_get_tclk_freq() give me an appropriate answer depending on the SoC. 
> > If this were in the mach-mvebu code I could just use mvebu_get_soc_id() 
> > to fetch the device id. Is there an equivalent I could use in generic code?
> > 
> > One option would be to use a different compatible string in the dts. 
> > That would also give me a way of handling other differences (the 
> > clock-gating is a subset of what's available on the armada-xp). How 
> > different would things have to be before it's worth spinning the PP code 
> > out into a file of it's own?
> 
> To me, it indeed seems like you need a different compatible string
> here. Whether a separate file from drivers/clk/mvebu/armada-xp.c is
> needed or not will depend on whether only the tclk frequency differs,
> or whether also the ratios with other clocks differ.

I agree here about the compatibility string. The Kirkwood PP also has
a different compat string for some drivers and an .dtsi file.

kirkwood-98dx4122.dtsi

	Andrew
