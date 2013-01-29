From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Jan 2013 16:01:34 +0000
Subject: [PATCH 09/30] USB: ehci-omap: Use devm_request_and_ioremap()
In-Reply-To: <Pine.LNX.4.44L0.1301291033000.1507-100000@iolanthe.rowland.org>
References: <20130128152010.GN23505@n2100.arm.linux.org.uk>
 <Pine.LNX.4.44L0.1301291033000.1507-100000@iolanthe.rowland.org>
Message-ID: <20130129160134.GC23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 10:34:53AM -0500, Alan Stern wrote:
> On Mon, 28 Jan 2013, Russell King - ARM Linux wrote:
> 
> > On Mon, Jan 28, 2013 at 10:17:33AM -0500, Alan Stern wrote:
> > > On Mon, 28 Jan 2013, Roger Quadros wrote:
> > > 
> > > > Make use of devm_request_and_ioremap() and correct comment.
> > > 
> > > Didn't a big patch come through recently converting all usages of 
> > > devm_request_and_ioremap() to another function (I forget the name) that 
> > > does its own error reporting and returns an ERR_PTR value?
> > > 
> > > (Checks the mailing list archive...)  Ah, here it is:
> > > 
> > > 	http://marc.info/?l=linux-usb&m=135876311801537&w=2
> > > 
> > > And the new function is devm_ioremap_resource().  We should avoid 
> > > adding new usages of an old interface.
> > 
> > Maybe... if devm_ioremap_resource() was already in the kernel.  The
> > problem at the moment is it isn't, and it'll probably be rather
> > horrid for everyone to deal with especially when it comes to testing.
> 
> Not in the kernel yet?  I didn't realize that.  Looks like Thierry 
> Reding will have some clean-up work to do when it does get in.

It may be in linux-next, but it isn't in Linus' yet... (of course, it's
probably scheduled for the upcoming merge window).  Certainly:

$ grep -r devm_ioremap_resource include

against Linus' tree (6abb7c2) still turns up nothing.
