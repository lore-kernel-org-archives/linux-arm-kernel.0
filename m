From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 15 Mar 2013 10:30:37 -0400 (EDT)
Subject: [PATCH] USB: EHCI: fix for leaking isochronous data
In-Reply-To: <51426484.3000609@web.de>
Message-ID: <Pine.LNX.4.44L0.1303151028100.1414-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Mar 2013, Soeren Moch wrote:

> > The log shows a 1-1 match between allocations and deallocations, except
> > for three excess allocations about 45 lines before the end.  I have no
> > idea what's up with those.  They may be an artifact arising from where
> > you stopped copying the log data.
> >
> > There are as many as 400 iTDs being allocated before any are freed.
> > That seems like a lot.  Are they all for the same isochronous endpoint?
> > What's the endpoint's period?  How often are URBs submitted?
> 
> I use 2 dvb sticks, capturing digital TV. For each stick 5 URBs on a 
> single endpoint are used, I think. I'm not sure, which endpoint in which 
> alternateSetting is active. I attached the output of 'lsusb -v' for the 
> sticks.
> How can I track down the other information you need?

Use usbmon (see Documentation/usb/usbmon.txt).

Alan Stern
