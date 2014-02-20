From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Feb 2014 13:09:44 +0100
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <20140220105854.GL11878@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1392892217.23342.18.camel@kazak.uk.xensource.com>
 <20140220105854.GL11878@lunn.ch>
Message-ID: <2309805.FlfIt1u0R7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 February 2014 11:58:54 Andrew Lunn wrote:
> 
> > I still need to figure out how to distinguish the variations, but I
> > think I have a plan there (via which PCI buses are present, which is a
> > bit skanky but seems like the most workable solution).
> 
> Having the SoC ID available via lspci for systems using the new PCI
> driver might be in 3.14. It was considered a regression so might get
> merged into an rc. If not, it will be in 3.15.
> 
> We have also talked about putting the SOC version and revision into
> /proc/cpuinfo, in the Revision field. However this has not happened
> yet.

Another option would be to use the soc bus to provide that information
in /sys/devices/soc, and put the rest of the devices under that
node.

	Arnd
