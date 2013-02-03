From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 3 Feb 2013 17:14:05 -0500
Subject: [PATCH v2] rtc: rtc-mv: Add support for clk to avoid lockups
In-Reply-To: <20130203194407.GA16366@schnuecks.de>
References: <1359891126-21909-1-git-send-email-andrew@lunn.ch>
 <20130203194407.GA16366@schnuecks.de>
Message-ID: <20130203221405.GF14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 03, 2013 at 08:44:07PM +0100, Simon Baatz wrote:
> Hi Andrew,
> 
> On Sun, Feb 03, 2013 at 12:32:06PM +0100, Andrew Lunn wrote:
> > The Marvell RTC on Kirkwood makes use of the runit clock. Ensure the
> > driver clk_prepare_enable() this clock, otherwise there is a danger
> > the SoC will lockup when accessing RTC registers with the clock
> > disabled.
> > 
> > Reported-by: Simon Baatz gmbnomis at gmail.com
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> And:
> 
> Tested-by: Simon Baatz <gmbnomis@gmail.com>
> 
> Btw, <...> is missing from the email address in the Reported-by line.

I'll clean that up.  no need for a new version.

> Thanks for providing this so quickly. Now, it looks like this
> (without applying the GPIO fix, yet, because it would already enable
> the runit clock):
> 
> # cat /sys/kernel/debug/clk/tclk/runit/clk_enable_count
> 0
> # insmod ./rtc-mv.ko
> # cat /sys/kernel/debug/clk/tclk/runit/clk_enable_count
> 1
> # hwclock
> Sun Feb  3 19:34:53 2013  -1.003522 seconds
> # rmmod rtc-mv
> # cat /sys/kernel/debug/clk/tclk/runit/clk_enable_count
> 0

Great!  Thanks for turning around those tests so quickly.

thx,

Jason.
