From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 10 Apr 2014 20:02:22 +0200
Subject: Fixing PCIe issues on Armada XP
In-Reply-To: <20140410171000.GF25890@1wt.eu>
References: <20140410181953.50ccfcc3@skate>
	<20140410171000.GF25890@1wt.eu>
Message-ID: <20140410200222.27cab16e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Willy Tarreau,

On Thu, 10 Apr 2014 19:10:00 +0200, Willy Tarreau wrote:

> Thanks for putting all this online.
> 
> I have a minor comment below :
> 
> >  * 2 patches on the pci-mvebu driver. One from Willy Tarreau to fix the
> >    off by one on the sizes. And another one from me which splits the
> >    PCI BAR into power-of-two sized chunks, in order to create valid
> >    MBus windows.
> 
> As suggested by Jason, this one should be merged before his that's just
> before, to ensure that it will not cause a regression.

Ok, will change this, thanks.

> > I've tested this with my IGB card which needs a 9 MB
> >    BAR (so 8 MB + 1 MB needed), and I've also faked the code to code to
> >    simulate a 11.5 MB BAR (so 8 + 2 + 1 + 0.5 MB), and it worked. I
> >    also checked that if we have an error when creating one of the
> >    windows, then all the previous windows needed for the current BAR
> >    are properly removed.
> 
> Really cool, I'm going to test that on a few PCIe cards and will report
> the results here. How can we check the number of mbus windows in use ?

# cat /sys/kernel/debug/mvebu-mbus/devices

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
