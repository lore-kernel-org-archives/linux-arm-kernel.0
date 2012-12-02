From: w@1wt.eu (Willy Tarreau)
Date: Mon, 3 Dec 2012 00:48:27 +0100
Subject: [PATCH] ARM: kirkwood: convert Guruplug to use the device tree
In-Reply-To: <20121202234110.GM12509@titan.lakedaemon.net>
References: <20121202155124.GA30807@1wt.eu>
 <20121202230926.GJ12509@titan.lakedaemon.net> <20121202232226.GL30822@1wt.eu>
 <20121202234110.GM12509@titan.lakedaemon.net>
Message-ID: <20121202234827.GM30822@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 02, 2012 at 06:41:10PM -0500, Jason Cooper wrote:
> On Mon, Dec 03, 2012 at 12:22:26AM +0100, Willy Tarreau wrote:
> > Hi Jason,
> > 
> > On Sun, Dec 02, 2012 at 06:09:26PM -0500, Jason Cooper wrote:
> > > Willy,
> > > 
> > > Great first DT patch!  A few comments below.
> > > 
> > > On Sun, Dec 02, 2012 at 04:51:24PM +0100, Willy Tarreau wrote:
> > > > Add a device tree entry for the Guruplug board. This port was
> > > > based both on the work done on the dreamplug and the dockstar.
> > > > 
> > > > It builds, boots and works on my Guruplug Server plus.
> > > 
> > > iirc, the Guruplug Server Plus has an esata port.  Since this is the
> > > hardware you have, lets make this patch specific to it.  So, the Subject
> > > line should refer to "Guruplug Server Plus", and
> > 
> > (...)
> > 
> > Thank you for your review and clear comments, I'll update the patch
> > accordingly.
> > 
> > Since there are already pending changes for the merge window, I'll
> > rather resend it after the merge window when the changes are already
> > done, what do you think ?
> 
> Doesn't matter in this case, I'll handle any conflicts.  Please resend
> when ready.  You can just base off of v3.7-rc7, or v3.8 if it drops.

OK will do.

> btw - did you upgrade u-boot for DT?

I remember I upgraded it recently because of the incompatibility with
kernels >= 3.2 causing random hangs at boot, but I don't know if it
supports DT.

> You should just have to add
> CONFIG_OF_LIBFDT to include/configs/guruplug.h.  Then,
> 
> bootm <kern addr> <initrd addr> <dtb addr>
> 
> Without an initrd,
> 
> bootm <kern addr> - <dtb addr>

Interesting, I'll have to check (I've put it back into my bag right
now).

Thanks!
Willy
