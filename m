From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 30 May 2017 16:03:20 +0200
Subject: [PATCH 4/6] irqchip: irq-mvebu-icu: new driver for Marvell ICU
In-Reply-To: <20170530134226.GR22219@n2100.armlinux.org.uk>
References: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496135772-20694-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170530121907.GO22219@n2100.armlinux.org.uk>
 <20170530143350.6f8563c1@free-electrons.com>
 <20170530125643.GQ22219@n2100.armlinux.org.uk>
 <20170530132735.GA21646@lunn.ch>
 <20170530134226.GR22219@n2100.armlinux.org.uk>
Message-ID: <20170530140320.GA22758@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1;4601;0cOn Tue, May 30, 2017 at 02:42:26PM +0100, Russell King - ARM Linux wrote:
> On Tue, May 30, 2017 at 03:27:35PM +0200, Andrew Lunn wrote:
> > So you don't expect to every have your 500 patches merged?
> 
> Correct.
> 
> > What might help is that you ask for help getting them merged. I know
> > of at least 4 groups of people interested in your devlink and 10G PHY
> > code.
> 
> As I've repeatedly explained - and it's called phylink, not devlink -

Sorry, my error. To many different -link things in the network stack.

> the SFP support is not ready due to the SFP+ stuff needing a complete
> rewrite of that code, which has been delayed because of delays on
> SolidRun's side to provide SFP+ hardware.

Linux has a long history of reworking stuff in tree, when it has been
shown to be inadequate in its first version. So long as the device
tree binding does not need incompatible changes, this reworking is not
an issue. My guess is, a lot of people have SFP sockets, not
SFP+. Lets get SFP merged, and then rework it in tree to add SFP+.

> Much of the changes for that happened during the last month, but are
> currently rather dirty and incomplete, but are in a working state.
> As you know, I had been pushing out the 10G PHY changes as quickly as
> netdev copes with them during the previous kernel cycle.  The rate of
> patch merging was completely insufficient to get the 10G support into
> netdev - with it taking a week or longer between patches posted and
> the merge happening.

netdev is the fastest tree i've worked in to get stuff merged. It
averages around 3 days. But it requires both sides to be very active,
submitters and reviewers.

> > You are great at writing new code, but terrible at getting it
> > merged.
> 
> Yes, because I find it very very time consuming and frustrating to
> deal with other people - it's really not easy.

So as i suggested, outsource that part of the work.

   Andrew
