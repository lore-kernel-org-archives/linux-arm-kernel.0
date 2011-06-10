From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Fri, 10 Jun 2011 14:47:30 +0100 (BST)
Subject: [linux-pm] [RFC PATCH v4] ARM hibernation/suspend-to-disk support
In-Reply-To: <20110610134311.GK24424@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.1106071722040.2236@localhost6.localdomain6>
	<201106072348.44624.rjw@sisk.pl>
	<alpine.DEB.2.00.1106091604180.11513@localhost6.localdomain6>
	<20110609154058.GA24424@n2100.arm.linux.org.uk>
	<4DF0F45A.3030103@ti.com>
	<20110609164024.GB24424@n2100.arm.linux.org.uk>
	<4DF0FA73.8050607@ti.com>
	<20110609171255.GD24424@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106101110130.11513@localhost6.localdomain6>
	<20110610134311.GK24424@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1106101444490.20826@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Jun 2011, Russell King - ARM Linux wrote:

[ ... ]
> What's the point when platform code has *ALREADY* to call these functions?
>
> Is it really too sodding difficult for platforms to do:
>
> my_suspend_hook()
> {
> 	mach_pre_suspend_hook();
> 	cpu_suspend();
> 	mach_post_suspend_hook();
> }
>
> ?
>
> <not read the rest of the message, this is getting idiotic>
>

Sorry for being unclear.

Yes, they already have to do all this. And they should.


Except for one thing:

They all, IN ADDITION, do ALSO:

 	wfi();			/* or whatever else to power down */


For Hibernation, _THAT_ needs to be out of the codepath.


So that one can snapshot without powering down.

FrankH.
