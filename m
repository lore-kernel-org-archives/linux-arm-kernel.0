From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 1 Mar 2012 00:53:26 +0100
Subject: [PATCH 2/3 v4] arm: kirkwood: add dreamplug (fdt) support.
In-Reply-To: <20120229144450.GB23524@titan.lakedaemon.net>
References: <20120224075753.GA24858@lunn.ch>
 <20120229144450.GB23524@titan.lakedaemon.net>
Message-ID: <20120229235326.GA3207@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 09:44:50AM -0500, Jason wrote:
> Andrew,
> 
> On Fri, Feb 24, 2012 at 08:57:53AM +0100, Andrew Lunn wrote:
> > I have some patches under development which will help.
> 
> Any chance you could shoot those to me?  (on-list preferable)  I'm
> thinking we could convert it to an interim solution eg
> kirkwood_{get,put}_clock() that would be easy to migrate to generic
> CLK/clkdev once it lands.

Hi Jason

It is not that easy. It is not kirkwood, but all platform orion, so
includes dove, orion5x, mv78xx0 and kirkwood. All these share the same
device drivers, since they all share the same SoC peripheral
cores. However, only kirkwood has per peripheral gated clocks and all
the others share tclk.

I've also broke orion5x twice so far with my patches, since i don't
have any hardware with that SoC. So this time i was hoping to ask for
testing on orion5x before submitting to mainline.

Mike did say he hoped the generic clk would be ready last week. Maybe
we should ping him and ask for a new ETA?

	Andrew
