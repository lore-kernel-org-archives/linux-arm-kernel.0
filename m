From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 May 2017 16:08:01 +0100
Subject: [PATCH 4/6] irqchip: irq-mvebu-icu: new driver for Marvell ICU
In-Reply-To: <20170530144934.GB22758@lunn.ch>
References: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496135772-20694-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170530121907.GO22219@n2100.armlinux.org.uk>
 <20170530143350.6f8563c1@free-electrons.com>
 <20170530125643.GQ22219@n2100.armlinux.org.uk>
 <20170530132735.GA21646@lunn.ch>
 <20170530143902.GU22219@n2100.armlinux.org.uk>
 <20170530144934.GB22758@lunn.ch>
Message-ID: <20170530150801.GV22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 30, 2017 at 04:49:34PM +0200, Andrew Lunn wrote:
> On Tue, May 30, 2017 at 03:39:02PM +0100, Russell King - ARM Linux wrote:
> > On Tue, May 30, 2017 at 03:27:35PM +0200, Andrew Lunn wrote:
> > > What might help is that you ask for help getting them merged. I know
> > > of at least 4 groups of people interested in your devlink and 10G PHY
> > > code. If you handed those patches over to these people, i'm sure we
> > > could find somebody to post them to the list, deal with the feedback,
> > > etc, to get them merged. It just needs you to say it is O.K. for
> > > somebody to take patches from your git tree.
> > 
> > Is that not what I'm trying to do with these A8k changes?  What I'm
> > instead getting is "your tree is private, we're not touching it".
> > 
> > Okay, so let me put it another way: please help me merge the A8k
> > changes that I have in my tree.
> 
> Hi Russell
> 
> So you are happy for Free-Electrons, or anybody else, to take patches
> from your tree, submit them, handle comments, resubmit them, etc?

I am happy for the A8k changes, provided there's coordination, so we
reasonably avoid to duplicate effort, but I think we're already at
the point where most of my effort has already been duplicated.

If someone wants to take (eg) my ICU patches and fit what's appropriate
on top of Thomas', then I'd welcome that effort.

Obviously, the PP2x changes in my tree are no-hopers for mainline as
the decision has been made to improve the existing PP2 driver, and
I think the gpio/pinctrl changes are now no-hopers as that work has
already been done independently.

I'm not sure there's much other stuff left out of the 63 patches that
comprise my "mvebu" branch as far as core A8k changes go.

For the mcbin changes (that come after the mvebu/phy merge), I think
everything up to and including "arm64: dts: marvell: mcbin: add GPIO"
is probably mainline-candidates (except for the PP2 driver obviously),
the sdhci DTS patch has already been picked up.

"arm64: dts: marvell: mcbin: workaround wrongly wired i2c1 bus" is
definitely not for mainline, as that is only for early revision
boards, and SR does not want that merged into mainline (as stated
in its commit log.)

"arm64: dts: marvell: mcbin: add remainder of pinctrls" and
"usb: host: xhci: mvebu: add reset on resume quirk" might also be
candidates, I'm not sure without looking further.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
