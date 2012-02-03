From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 3 Feb 2012 12:47:29 -0800
Subject: [PATCH 1/5] USB: sa1111: sparse and checkpatch cleanups
In-Reply-To: <20120203203810.GK14129@n2100.arm.linux.org.uk>
References: <20120203200406.GI14129@n2100.arm.linux.org.uk>
 <E1RtPRY-00048Q-MI@rmk-PC.arm.linux.org.uk>
 <20120203203228.GA23778@kroah.com>
 <20120203203810.GK14129@n2100.arm.linux.org.uk>
Message-ID: <20120203204729.GA757@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2012 at 08:38:10PM +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 03, 2012 at 12:32:28PM -0800, Greg KH wrote:
> > On Fri, Feb 03, 2012 at 08:09:12PM +0000, Russell King - ARM Linux wrote:
> > > Clean up the ohci-sa1111 driver formatting to be more compliant with
> > > current standards, and add 'static' to various function definitions
> > > to avoid sparse complaints about undeclared functions.  Remove the
> > > unnecessary local declaration of 'usb_disabled', which can be found
> > > instead in linux/usb.h.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > Do you want me to take these 5 patches through the USB tree?  Or are you
> > going to take them through an ARM tree?
> 
> I forgot to send the introduction to linux-usb, so you've probably missed
> the comment that they depend on some previous patches.

Yeah, I missed that :)

If these depend on other patches, feel free to take them in your tree
then.

> > Either is fine with me, if ARM, feel free to add:
> > 	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > to them.
> 
> There was one question mark I had over a patch - that was the addition
> of the .reset method in the hc_driver for sa1111 stuff.  This seems to
> only get called once during initial driver bring-up.  Comments I found
> in the code suggest that it was used more often in the past.  Is that
> something that's going away?

I don't think so, but Alan (on linux-usb@) would be the best to answer
that one.

thanks,

greg k-h
