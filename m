From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 5 Oct 2013 22:42:08 +0200
Subject: [PATCH] clk: provide public clk_is_enabled function
In-Reply-To: <20131005202430.GI10079@pengutronix.de>
References: <1380881310-24345-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20131005202430.GI10079@pengutronix.de>
Message-ID: <20131005204208.GB28106@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 05, 2013 at 10:24:30PM +0200, Uwe Kleine-K?nig wrote:
> On Fri, Oct 04, 2013 at 12:08:30PM +0200, Sebastian Hesselbarth wrote:
> > To determine if a clk has been previously enabled, provide a public
> > clk_is_enabled function. This is especially helpful to check the state
> > of clk-gate without actually changing the state of the gate.
> I wonder what you want to do with the return value.
> 
> When doing
> 
> 	if (clk_is_enabled(someclk))
> 		do_something();
> 
> you cannot in general know if the clock is still on when you start to
> do_something.

Hi Uwe

At least in the use case Sebastian needs it for, we don't need an "in
general" solution. It is used early boot time to see if the boot
loader left the clock running. The other user of the clock is the
ethernet driver, which we know cannot change it yet, because driver
probing has not started yet.

	Andrew
