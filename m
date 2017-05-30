From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 May 2017 14:42:26 +0100
Subject: [PATCH 4/6] irqchip: irq-mvebu-icu: new driver for Marvell ICU
In-Reply-To: <20170530132735.GA21646@lunn.ch>
References: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496135772-20694-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170530121907.GO22219@n2100.armlinux.org.uk>
 <20170530143350.6f8563c1@free-electrons.com>
 <20170530125643.GQ22219@n2100.armlinux.org.uk>
 <20170530132735.GA21646@lunn.ch>
Message-ID: <20170530134226.GR22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 30, 2017 at 03:27:35PM +0200, Andrew Lunn wrote:
> So you don't expect to every have your 500 patches merged?

Correct.

> What might help is that you ask for help getting them merged. I know
> of at least 4 groups of people interested in your devlink and 10G PHY
> code.

As I've repeatedly explained - and it's called phylink, not devlink -
the SFP support is not ready due to the SFP+ stuff needing a complete
rewrite of that code, which has been delayed because of delays on
SolidRun's side to provide SFP+ hardware.

Much of the changes for that happened during the last month, but are
currently rather dirty and incomplete, but are in a working state.
As you know, I had been pushing out the 10G PHY changes as quickly as
netdev copes with them during the previous kernel cycle.  The rate of
patch merging was completely insufficient to get the 10G support into
netdev - with it taking a week or longer between patches posted and
the merge happening.

> You are great at writing new code, but terrible at getting it
> merged.

Yes, because I find it very very time consuming and frustrating to
deal with other people - it's really not easy.

What am I working on right now - I'm trying to get the dw-hdmi CEC
driver out there.  I've been working on that all morning so far,
but it's taking hours, despite having a previously working patch
set... and the latest problem I find is that iMX6 appears to silently
fail to boot.  So, this afternoon, I'm debugging why 4.12-rc3 on
iMX6 seems to be broken, and while I'm doing that I won't be doing
anything _else_, probably not even looking at any email.  So this
will probably be the last email you see from me until I have the
dw-hdmi stuff sorted.  That means I won't be doing _anything_ else
while I sort out a set of patches for this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
