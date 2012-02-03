From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 3 Feb 2012 15:59:50 -0500 (EST)
Subject: [PATCH 1/5] USB: sa1111: sparse and checkpatch cleanups
In-Reply-To: <20120203204729.GA757@kroah.com>
Message-ID: <Pine.LNX.4.44L0.1202031557380.1598-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Feb 2012, Greg KH wrote:

> > There was one question mark I had over a patch - that was the addition
> > of the .reset method in the hc_driver for sa1111 stuff.  This seems to
> > only get called once during initial driver bring-up.  Comments I found
> > in the code suggest that it was used more often in the past.  Is that
> > something that's going away?
> 
> I don't think so, but Alan (on linux-usb@) would be the best to answer
> that one.

The "reset" method is not named very well; it really should be called
"initialize".  At any rate, you're right -- it gets called exactly once
during the lifetime of the HC, and no, that's not going to change.

Alan Stern
