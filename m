From: greg@kroah.com (Greg KH)
Date: Fri, 8 Oct 2010 17:54:22 -0700
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <20101009002546.GB14675@n2100.arm.linux.org.uk>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101007192245.GC26435@n2100.arm.linux.org.uk>
	<AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
	<20101008175308.GA10975@n2100.arm.linux.org.uk>
	<AANLkTi=ERZjVDS=Q7aw1zA23KF68irUP3vvKLZw5meBU@mail.gmail.com>
	<20101008230451.GB10975@n2100.arm.linux.org.uk>
	<20101008232539.GA28697@kroah.com>
	<20101008234448.GD10975@n2100.arm.linux.org.uk>
	<20101009000046.GA30616@kroah.com>
	<20101009002546.GB14675@n2100.arm.linux.org.uk>
Message-ID: <20101009005422.GA21180@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 09, 2010 at 01:25:47AM +0100, Russell King - ARM Linux wrote:
> On Fri, Oct 08, 2010 at 05:00:46PM -0700, Greg KH wrote:
> > But you can't expect that you make this change, and not fix up the
> > drivers, and people would be happy, right?  The rule for API changes
> > like this, or anything, is that the person making the change fixes the
> > other drivers, and that seems to be the issue here.
> 
> Let's entirely revert the change and wait for people's data to be
> corrupted then.  I don't have the time nor the motivation to work
> through crap driver code to fix up these unreliable games which are
> already illegal on platforms such as x86.
> 
> If people want their system to be unpredictable, then let's carry on
> giving them the rope to hang themselves in that manner.
> 
> > Any pointers to patches where people have fixed up the drivers?
> 
> Despite the discussion, I'm unaware of anyone really taking the issue
> seriously and producing any patches during the last six months.
> 
> So, I say sod it, let's revert the change.

Well, how about throw a big WARN() to let people know that their driver
needs to be fixed?  That will give them the chance, right?

thanks,

greg k-h
