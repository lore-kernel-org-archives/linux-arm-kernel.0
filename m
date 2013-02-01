From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 31 Jan 2013 17:19:32 -0700
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <20130201000109.GK7717@titan.lakedaemon.net>
References: <20130129004824.GB7717@titan.lakedaemon.net>
 <20130129194243.GA30831@schnuecks.de> <51082C4E.5050903@gmail.com>
 <20130130000341.GA10600@schnuecks.de> <51086E86.8040705@gmail.com>
 <20130130083044.GA25688@schnuecks.de> <5108F300.7000705@gmail.com>
 <20130130230100.GV7717@titan.lakedaemon.net>
 <20130131224457.GB17976@schnuecks.de>
 <20130201000109.GK7717@titan.lakedaemon.net>
Message-ID: <20130201001932.GA13044@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 07:01:09PM -0500, Jason Cooper wrote:

> If you're interested, I still have a few ideas.  One was to wire two USB
> serial adapters end to end to create a different console
> (console=/dev/ttyUSB0,115200, getty, etc).  Since they would be going
> over usb, that's a different clock, so it should work and provide us
> with a safety net.

I can't recall, can you still use JTAG once the CPU has hung on a mbus
access?

If so memory dumping the console ring, or cpu registers would get the
answer pretty directly..

My guesses would be the RTC and/or GPIO blocks (the GPIO blinker needs
a clock), based on table 94.

Jason
