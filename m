From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Tue, 14 Nov 2017 12:31:44 +0100
Subject: [v11,1/4] drivers: jtag: Add JTAG core driver
In-Reply-To: <20171114111916.GO12318@n2100.armlinux.org.uk>
References: <1509724449-26221-2-git-send-email-oleksandrs@mellanox.com>
 <8760aoz78q.fsf@bilbrey.org>
 <DB6PR0501MB219753AC43515148F39CC2D0B1280@DB6PR0501MB2197.eurprd05.prod.outlook.com>
 <20171114111046.GA23820@kroah.com>
 <20171114111916.GO12318@n2100.armlinux.org.uk>
Message-ID: <20171114113144.GA25234@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 14, 2017 at 11:19:16AM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 14, 2017 at 12:10:46PM +0100, gregkh at linuxfoundation.org wrote:
> > On Tue, Nov 14, 2017 at 10:34:49AM +0000, Oleksandr Shamray wrote:
> > > Greg, what you can suggest about it. May be better to add again single-open()-per-device lock with right locking way like:
> > > 
> > > >if (mutex_lock_interruptible(&jtag->open_lock)) {
> > 
> > You would stall an open?  Why not just return saying you can't do that?
> 
> Greg, I think you need to look at the code again.

Heh, sorry, I probably got it wrong.  I'll be glad to review it in a
real patch when needed, but not in the middle of the merge window :)

thanks,

greg k-h
