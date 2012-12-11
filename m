From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 11 Dec 2012 07:00:50 +0100
Subject: [PATCH 1/2] arm: mvebu: add RTC support for Armada 370 and
 Armada XP
In-Reply-To: <20121210233723.1f3656d0@skate>
References: <1355136122-30729-1-git-send-email-gregory.clement@free-electrons.com>
 <1355136122-30729-2-git-send-email-gregory.clement@free-electrons.com>
 <20121210162819.46fe4f91@skate>
 <20121210214755.9CD823E0C7C@localhost>
 <20121210233723.1f3656d0@skate>
Message-ID: <20121211060050.GC25466@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 11:37:23PM +0100, Thomas Petazzoni wrote:
> Dear Grant Likely,
> 
> On Mon, 10 Dec 2012 21:47:55 +0000, Grant Likely wrote:
> 
> > > Maybe an explicit status = "okay" here?
> > 
> > Only necessary if it is typical for the device to get disabled. I don't
> > add status="okay" properties unless it is to enable a device previously
> > disabled with status="disabled"
> 
> Ok, thanks for clarifying what the best practice is. This device being
> internal to the SoC and having no dependency on external components, it
> is indeed always available.

Hi Thomas

This is not actually true. Its dependent on at least one external
component, a battery. The driver determines at load time if the clock
is ticking.

There are a few Kirkwood and XP designs which use an external i2c RTC,
because the battery recommended by Marvell is mechanically not so easy
to attached to the board, in a robust way.

So i expect some boards will disable this from there own .dts file.
However, defaulting to enabled would make sense.

   Andrew
