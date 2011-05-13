From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 May 2011 19:14:57 +0100
Subject: [PATCH] pxa/hx4700: Avoid unbalanced irq wakeup enables/disables
In-Reply-To: <20110513101348.GA18716@rainbow>
References: <E1QHn5f-0004Rb-6j@outmx07.plus.net>
	<20110513101348.GA18716@rainbow>
Message-ID: <20110513181456.GD19733@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2011 at 02:13:49PM +0400, Dmitry Artamonow wrote:
> Not sure if it's right to allow only POWER button to wake the device.
> In both Windows CE and handhelds.org 2.6.21 kernel any button can wake
> device, and even start corresponding action (i.e. run some app) after wakeup.

Ah, I'm glad you mentioned that.

This 'feature' is really annoying, as it keeps resulting in my iPAQ
battery being drained completely.  My iPAQ now lives plugged into its
charger because that's the only way I can ensure that the programs and
data on it stay there.  If I put it anywhere else, a button will get
pressed unnoticed and then I'll have to reload everything back on to it.

So really, whether a non-power button wakes up or not should be ultimately
end-user configurable.  Wish it was in wince.
