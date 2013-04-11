From: horms@verge.net.au (Simon Horman)
Date: Thu, 11 Apr 2013 09:51:56 +0900
Subject: [PATCH v3 0/9] Reorganize R8A7779/Marzen USB code
In-Reply-To: <20130410090543.GB25890@verge.net.au>
References: <201304100226.08967.sergei.shtylyov@cogentembedded.com>
 <20130410044923.GD10044@verge.net.au>
 <20130410085033.GL7983@arwen.pp.htv.fi>
 <20130410090543.GB25890@verge.net.au>
Message-ID: <20130411005155.GA18530@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 06:05:43PM +0900, Simon Horman wrote:
> On Wed, Apr 10, 2013 at 11:50:33AM +0300, Felipe Balbi wrote:
> > Hi,
> > 
> > On Wed, Apr 10, 2013 at 01:49:23PM +0900, Simon Horman wrote:
> > > On Wed, Apr 10, 2013 at 02:26:08AM +0400, Sergei Shtylyov wrote:
> > > > Hello.
> > > > 
> > > >    Here's the set of 9 patches against the Simon Horman's 'renesas.git' repo,
> > > > 'renesas-next-20130410' tag.  It was created to fix the shortcomings in the
> > > > R8A7779/Marzen USB platform code and R8A7779 USB common PHY driver, and so
> > > > spans both arch/arm/mach-shmobile/ and drivers/usb/ subtrees (some patches have
> > > > to touch both subtrees). The patches were conceived with the complete
> > > > bisectability goal in mind.
> > > > 
> > > > [1/9] ARM: shmobile: Marzen: move USB EHCI, OHCI, and PHY devices to R8A7779 code
> > > > [2/9] ehci-platform: add pre_setup() method to platform data
> > > > [3/9] ARM: shmobile: R8A7779: setup EHCI internal buffer
> > > > [4/9] rcar-phy: remove EHCI internal buffer setup
> > > > [5/9] ARM: shmobile: R8A7779: remove USB PHY 2nd memory resource
> > > > [6/9] rcar-phy: correct base address
> > > > [7/9] rcar-phy: add platform data
> > > > [8/9] ARM: shmobile: Marzen: pass platform data to USB PHY device
> > > > [9/9] rcar-phy: handle platform data
> > > > 
> > > >    I'm not sure thru which tree this patchset should be merged, however it turns
> > > > out that it's too late now to push it thru Felipe Balbi's USB tree for 3.10
> > > > (which would have been most convenient probably), and it's probably too late to
> > > > merge thru Simon's tree for 3.10 too. So it now have to be postponed to 3.11,
> > > > unfortunately...
> > > 
> > > Felipe, how would you prefer to handle this?
> > > I'm happy for you to take it or to take it myself.
> > 
> > please take it yourself, just keep in mind there will be conflicts, I
> > will go over the patches now and give my Acked-by so you can queue them
> > up.
> 
> Thanks

Sergei, it looks like patches 1-7 are clear.
Do you want me to start queueing them up.
Or would you rather wait for the issue with patch 6 to be resolved?
