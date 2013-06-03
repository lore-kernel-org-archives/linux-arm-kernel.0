From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 03 Jun 2013 15:46:13 -0400 (EDT)
Subject: [PATCH] ARM: atags: add support for Marvell's u-boot
In-Reply-To: <20130603191730.GR3803@titan.lakedaemon.net>
References: <1370277937-2965-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130603171017.GN18614@n2100.arm.linux.org.uk> <20130603175629.GH5008@1wt.eu>
 <20130603181437.GO3803@titan.lakedaemon.net> <20130603183057.GA9868@1wt.eu>
 <20130603184148.GQ3803@titan.lakedaemon.net>
 <alpine.LFD.2.03.1306031502450.1200@syhkavp.arg>
 <20130603191730.GR3803@titan.lakedaemon.net>
Message-ID: <alpine.LFD.2.03.1306031538250.1200@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 3 Jun 2013, Jason Cooper wrote:

> On Mon, Jun 03, 2013 at 03:07:45PM -0400, Nicolas Pitre wrote:
> > On Mon, 3 Jun 2013, Jason Cooper wrote:
> > 
> > > On Mon, Jun 03, 2013 at 08:30:57PM +0200, Willy Tarreau wrote:
> > > > Well, in fact u-boot sets it on the MAC used to boot from the network
> > > > if such a boot is performed, but that's all. So in practice you boot
> > > > without the MAC address anywhere but in the ATAGs. I'd be happy to
> > > > find a way to parse non-standard atags in a board-specific file but
> > > > they're lost early it seems :-(
> > > 
> > > I assume they are in the u-boot environment.  As such, the only answer
> > > may be to have user space utilities like flash-kernel parse the
> > > environment and then customize the appended DT for the specific board.
> > 
> > Or some board specific code could dig them out of the flash.  That at 
> > least would make this hack localized while keeping the common code 
> > clean.
> 
> If it comes to that, I think I would rather tell users to put the mac
> address on the commandline.

That is certainly a simple and viable option.  You can manage your 
U-Boot environment to construct the final command line from multiple 
variables so that some are kept static and some others are user 
editable.

But for the record, there is a precedent for digging MAC addresses out 
of flash memory -- see

arch/arm/mach-orion5x/tsx09-common.c:qnap_tsx09_find_mac_addr()


Nicolas
