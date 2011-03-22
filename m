From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 22 Mar 2011 16:39:17 +0000
Subject: [PATCHv2 0/9] macb: add support for Cadence GEM
In-Reply-To: <20110322161811.GF6466@game.jcrosoft.org>
References: <1300184096-13937-1-git-send-email-jamie@jamieiles.com>
	<20110316.131734.242138246.davem@davemloft.net>
	<4D86F25A.7060405@atmel.com>
	<20110321111838.GC2610@pulham.picochip.com>
	<20110322161811.GF6466@game.jcrosoft.org>
Message-ID: <20110322163917.GD10058@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Christophe,

On Tue, Mar 22, 2011 at 05:18:11PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 11:18 Mon 21 Mar     , Jamie Iles wrote:
> > I have an existing tree for this at
> > 
> > 	git://github.com/jamieiles/linux-2.6-ji.git macb-gem
> > 
> > based off of 2.6.38 (with your ACK's now added) and I'd be happy with 
> > either route.
> but we must detect the gem via the version register and ditto for macb for
> avr32 and at91
> 
> so please rebase it over my patch
> 
> and you get my sob too

Would you mind respinning your patch without the changes to the clk 
stuff?  Otherwise we're changing it from compile time to version based, 
only to completely remove it in subsequent patches.

Also, can you confirm that the module ID's that you are using to 
differentiate between AT91 and AVR32 won't clash with MACB uses in 
other, non-at91/avr32 chips, or that it doesn't matter?

Jamie
