From: horms@verge.net.au (Simon Horman)
Date: Tue, 15 Jul 2014 21:28:31 +0900
Subject: [PATCH v5 8/8] ARM: shmobile: genmai-reference: Enable MTU2 in
 device tree
In-Reply-To: <20140715113606.GB25203@verge.net.au>
References: <1404911564-17380-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1404911564-17380-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20140710095430.GD2728@katana>
 <20140715085430.GB17806@verge.net.au>
 <20140715085815.GD17806@verge.net.au>
 <20140715113606.GB25203@verge.net.au>
Message-ID: <20140715122831.GG25333@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 08:36:06PM +0900, Simon Horman wrote:
> On Tue, Jul 15, 2014 at 05:58:15PM +0900, Simon Horman wrote:
> > On Tue, Jul 15, 2014 at 05:54:32PM +0900, Simon Horman wrote:
> > > On Thu, Jul 10, 2014 at 11:54:30AM +0200, Wolfram Sang wrote:
> > > > On Wed, Jul 09, 2014 at 03:12:44PM +0200, Laurent Pinchart wrote:
> > > > > No more device needs to be added from platform code when booting the
> > > > > reference platform, move MTU2 registration from setup-r7s72100.c to
> > > > > board-genmai.c and remove the now empty r7s72100_add_dt_devices()
> > > > > function.
> > > > > 
> > > > > As the genmai_add_standard_devices() function is now identical to the
> > > > > default init_machine implementation, remove it as well.
> > > > > 
> > > > > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > > 
> > > > Yay, tasty!
> > > > 
> > > > Reviewed-by: Wolfram Sang <wsa@sang-engineering.com>
> > > 
> > > Hi Laurent,
> > > 
> > > I am having some trouble with this patch.
> > > In particular the shmobile defconfig with an initrd added
> > > (to compensate for the lack of ethernet and thus NFS) does
> > > not seem to make it to userspace with this patch applied :(
> > > 
> > > I am dropping it for now, but could you look into it?
> > 
> > I have likewise dropped "ARM: shmobile: r7s72100: Add MTU2 device to DT"
> > for now.
> 
> I believe that I have tracked down the problem and that it is
> in "ARM: shmobile: r7s72100: Add MTU2 device to DT".
> I will describe it in a response to that patch.

Now that problem has been resolved I have re-queued-up this patch.
