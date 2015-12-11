From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 11 Dec 2015 17:39:47 +0300
Subject: [PATCH v4 01/58] mtd: nand: denali: add missing nand_release()
 call in denali_remove()
In-Reply-To: <20151211145320.1560fac3@bbrezillon>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
 <1449734442-18672-2-git-send-email-boris.brezillon@free-electrons.com>
 <20151211004008.GQ144338@google.com>
 <20151211145320.1560fac3@bbrezillon>
Message-ID: <20151211143947.GL5284@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 02:53:20PM +0100, Boris Brezillon wrote:
> Hi Brian,
> 
> On Thu, 10 Dec 2015 16:40:08 -0800
> Brian Norris <computersforpeace@gmail.com> wrote:
> 
> > On Thu, Dec 10, 2015 at 08:59:45AM +0100, Boris Brezillon wrote:
> > > Unregister the NAND device from the NAND subsystem when removing a denali
> > > NAND controller, otherwise the MTD attached to the NAND device is still
> > > exposed by the MTD layer, and accesses to this device will likely crash
> > > the system.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Cc: <stable@vger.kernel.org> #3.8+
> > 
> > Does this follow these rules, from
> > Documentation/stable_kernel_rules.txt?
> > 
> >  - It must be obviously correct and tested.
> > 
> >  - It must fix a real bug that bothers people (not a, "This could be a
> >    problem..." type thing).
> 
> As you wish, I'll remove those Cc and Fixes tags, or just drop the
> patch if you think it's useless...

The fixes tag is a separate thing from CCing stable.  It's useful on by
itself.  I always put the person who wrote the original patch in the To:
header so they can review and comment if I have made a mistake.

regards,
dan carpenter
