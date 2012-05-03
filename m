From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 May 2012 14:00:34 +0100
Subject: [PATCH] gpio: Add simple poweroff-gpio driver
In-Reply-To: <1336033446-18949-1-git-send-email-jm@lentin.co.uk>
References: <20120501195603.GW25584@lunn.ch>
 <1336033446-18949-1-git-send-email-jm@lentin.co.uk>
Message-ID: <20120503130034.GA897@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2012 at 09:24:06AM +0100, Jamie Lentin wrote:
> Given appropriate devicetree bindings, this driver registers a
> pm_power_off function to set a GPIO line high/low and power down
> your board.
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
> Here's an attempt at doing this. All works fine, I've not submitted a
> patch to use it since GPIO patches for kirkwood aren't finalised, but
> you can see it being used here:-
> 
> https://github.com/lentinj/linux.git v3.4-rc4-clk-next-orion-dnskw-gpio
> 
> The main issue is where to put it. I'm not convinced that drivers/gpio
> is an appropriate home, however drivers/power and drivers/hwmon (where
> drivers with similar purpose live) contain frameworks this is not part
> of. drivers/mfd has some modules that can power off, but this is hardly
> multifunction :) Could also give in and use drivers/misc.
> 
> Feedback appreciated.

We already have something like this, but specific to a group of SoCs.

Please take a look at arch/arm/mach-pxa/reset.c and consider the behaviour
found there, so we don't end up creating something which PXA can't use.
Thanks.

Note that some PXA platforms want the GPIO for resetting to be configured
as an input when it's not required to assert the reset signal.
