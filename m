From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Sep 2010 10:11:13 +0100
Subject: [PATCH 1/7] ARM: specify ZRELADDR for ARCH_TEGRA
In-Reply-To: <20100903192329.GB29821@pengutronix.de>
References: <20100903095504.GC13643@pengutronix.de>
	<1283507818-1573-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTi=7+TcOWu_62EWH6pwFUuizMT47tHJraaqzdJgp@mail.gmail.com>
	<20100903190155.GE17152@pengutronix.de>
	<AANLkTin2fEj2kRRoE+RSpBovApMaCKTs+DVz9wvj7M3u@mail.gmail.com>
	<20100903192329.GB29821@pengutronix.de>
Message-ID: <20100908091113.GB29914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 03, 2010 at 09:23:29PM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Fri, Sep 03, 2010 at 12:19:26PM -0700, Erik Gilling wrote:
> > On Fri, Sep 3, 2010 at 12:01 PM, Uwe Kleine-K?nig
> > > (hmm, I thought that patches that touch common files like
> > > arch/arm/Kconfig should go via rmk?!)
> > 
> > I looked and saw that others (specifically samsung) had submitted this
> > fix directly to Linus.  I'm still learning the ropes here and am happy
> > to hear some clarification either way.
>
> Note that just me wondering if it's right doesn't necessarily means it's
> not.  Russell, can you comment?  Is it trivial enough and obviously only
> tegra related that it's OK?

The problem happens when there's related changes already in others git
trees which clash or conflict with those changes.

This whole CONFIG_ZRELADDR thing seems like a step backwards towards a
situation where we will get conflicts with multiple changes - but without
gaining anything substantial in moving away from Makefile.boot.

Unless someone can come up with a real justification for CONFIG_ZRELADDR
I'm mindful to revert it.  (But - if people have sent these changes to
Linus already, that's going to make reverting it a lot harder.)
