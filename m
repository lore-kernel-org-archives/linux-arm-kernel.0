From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 21 Mar 2011 11:18:38 +0000
Subject: [PATCHv2 0/9] macb: add support for Cadence GEM
In-Reply-To: <4D86F25A.7060405@atmel.com>
References: <1300184096-13937-1-git-send-email-jamie@jamieiles.com>
	<20110316.131734.242138246.davem@davemloft.net>
	<4D86F25A.7060405@atmel.com>
Message-ID: <20110321111838.GC2610@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2011 at 02:38:18PM +0800, Nicolas Ferre wrote:
> On 3/17/2011 4:17 AM, David Miller :
> > From: Jamie Iles <jamie@jamieiles.com>
> > Date: Tue, 15 Mar 2011 10:14:47 +0000
> > 
> >> This patch series extends the Atmel MACB driver to support the Cadence
> >> GEM (Gigabit Ethernet MAC) to support 10/100 operation.  The GEM is
> >> based on the MACB block but has a few moved registers and bitfields.
> >> This patch series attempts to use the MACB accessors where block
> >> functionallity is identical and only overrides to GEM specific
> >> acccessors when needed.
> >>
> >> This has been runtested on a board with a Cadence GEM and compile tested
> >> for all at91 configurations and a number of avr32 configurations.
> >>
> >> Changes since v1:
> >> 	- AT91 now provides a fake "hclk" and "macb_clk" has been
> >> 	renamed to "pclk" to be consistent with AVR32.
> >> 	- Configurable GEM receive buffer size support has been added.
> >> 	- pr_foo() and dev_foo() have been converted to netdev_foo()
> >> 	where appropriate.
> >> 	- New conditional accessors (macb_or_gem_{read,write}l) have
> >> 	been introduced that do the conditional accesses dependent on
> >> 	macb/gem type.
> >> 	- GEM is now dynamically detected from the module ID rather than
> >> 	platform device name.
> >>
> >> Jean-Christophe, I haven't based this on your conditional clock patch as
> >> I wasn't sure what decision had been made on that and whether the
> >> at91/avr32 detection is reliable.
> > 
> > I'm happy to ACK this so you guys can merge this via one of the
> > ARM trees:
> > 
> > Acked-by: David S. Miller <davem@davemloft.net>
> 
> I add my:
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Now, tell me if we need to setup a git tree with this and make it 
> handled by linux-next (we do not have for at91 yet)?
> or Russell can take the series in a "devel" branch?

Thanks for testing Nicolas!

I have an existing tree for this at

	git://github.com/jamieiles/linux-2.6-ji.git macb-gem

based off of 2.6.38 (with your ACK's now added) and I'd be happy with 
either route.

Jamie
