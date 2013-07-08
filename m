From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 8 Jul 2013 14:34:30 -0400 (EDT)
Subject: [PATCH 2/2] USB: OHCI: make ohci-pxa27x a separate driver
In-Reply-To: <CAJFYCKHwHFVqC022iwAEGoncGykZD+wAoveq7XDvUk4_tSMqVQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1307081429380.879-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Jul 2013, Manjunath Goudar wrote:

> > Several aspects of this are strange.  For example, consider how you
> > used the private part of the ohci_hcd structure and how the variable
> > names are inconsistent with the other OHCI glue drivers.
> >
> >
> Here we are considering private date like "clk" and "*mmio_base". These are
> keeping separate from general ohci_hcd using pxa27x_ohci struct (As EHCI).
> 
> In this glue already used ohci as pxa27x_ohci variable that is what I used
> pxaohci as
> variable of  pxa27x_ohci struct.

You should make this driver look like all the other glue drivers.  That 
means you should change it so that "ohci" is the name of the struct 
ohci_hcd variable.  You can call the private structure "pxa_ohci".  And 
don't forget the '_' character; without it the variable's name is 
unreadable.

Also, you should store the private data in the ohci->private region.  
Change the current code so that it works like the other glue drivers.

Alan Stern
