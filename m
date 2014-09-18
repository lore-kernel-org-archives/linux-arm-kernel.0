From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 18 Sep 2014 13:17:34 -0400 (EDT)
Subject: [PATCH 2/2] ARM: vexpress: Remove non-DT code
In-Reply-To: <20140918075758.GA12361@n2100.arm.linux.org.uk>
References: <1410359618-3441-1-git-send-email-pawel.moll@arm.com>
 <1410359618-3441-2-git-send-email-pawel.moll@arm.com>
 <20140910145818.GG12361@n2100.arm.linux.org.uk>
 <1410363657.23973.48.camel@hornet>
 <20140917152735.GU12361@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1409172059050.8647@knanqh.ubzr>
 <20140918075758.GA12361@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1409181314080.8647@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Sep 2014, Russell King - ARM Linux wrote:

> On Wed, Sep 17, 2014 at 09:04:54PM -0400, Nicolas Pitre wrote:
> > On Wed, 17 Sep 2014, Russell King - ARM Linux wrote:
> > 
> > > As for TC2, I just don't bother with that.  It's really not worth the
> > > hastle.  I asked for help with that and got almost nothing.  Yes, there's
> > > Nicolas' uboot, which solves some problems, but getting the kernel to
> > > boot on TC2 turned out to be a dead loss - and no help with it was
> > > forthcoming.
> > 
> > TC2 is my main development board at the moment and it boots mainline 
> > perfectly.  If you want I can provide you with a tarball of everything 
> > you need to boot it, including my setup script and compiled kernel, to 
> > get you started.
> 
> Well, right now I have a slightly different view, because of the work on
> the FIQ stuff.
> 
> We currently have the situation where the GIC on CT9x4 appears to be
> different from other GICs, in that group 1 interrupts are never
> delivered.  As the GIC is indistinguishable from working parts, this
> currently squarely puts the Daniel's KGDB FIQ work, and work to use
> FIQ for dumping backtraces in the case of a spinlock lockup beyond the
> reach of the kernel right now, and nothing more than a local hack.
> 
> So, until we get to the bottom of this, I need Versatile Express support
> to stay as-is, so there's no extraneous variables in the platform.  That
> means right now I need the legacy stuff to stay as switching to DT will
> add a huge variable into what's going on.


No problem -- I'm just offering kickstart help whenever you wish to make 
your TC2 useful beyond a doorstop.


Nicolas
