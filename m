From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 14 Mar 2013 16:32:46 -0400 (EDT)
Subject: [PATCH] USB: EHCI: fix for leaking isochronous data
In-Reply-To: <51421B89.6020308@web.de>
Message-ID: <Pine.LNX.4.44L0.1303141630550.1194-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Mar 2013, Soeren Moch wrote:

> >> I added a debug message to
> >> drivers/usb/host/ehci-sched.c:itd_urb_transaction() to log the
> >> allocation flags, see log below.
> >
> > But it looks like you didn't add a message to end_free_itds(), so we
> > don't know when the memory gets deallocated.  And you didn't print out
> > the values of urb, num_itds, and i, or the value of itd (so we can
> > match up allocations against deallocations).
> 
> OK, I will implement this more detailed logging. But with several 
> allocations per second and runtime of several hours this will result in 
> a very long logfile.

If the memory really is being leaked here in some sort of systematic
way, we may be able to see it in your debugging output after a few
seconds.

Alan Stern
