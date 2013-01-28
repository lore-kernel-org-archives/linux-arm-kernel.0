From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Jan 2013 15:20:10 +0000
Subject: [PATCH 09/30] USB: ehci-omap: Use devm_request_and_ioremap()
In-Reply-To: <Pine.LNX.4.44L0.1301281013010.1997-100000@iolanthe.rowland.org>
References: <1359372631-8180-10-git-send-email-rogerq@ti.com>
 <Pine.LNX.4.44L0.1301281013010.1997-100000@iolanthe.rowland.org>
Message-ID: <20130128152010.GN23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 10:17:33AM -0500, Alan Stern wrote:
> On Mon, 28 Jan 2013, Roger Quadros wrote:
> 
> > Make use of devm_request_and_ioremap() and correct comment.
> 
> Didn't a big patch come through recently converting all usages of 
> devm_request_and_ioremap() to another function (I forget the name) that 
> does its own error reporting and returns an ERR_PTR value?
> 
> (Checks the mailing list archive...)  Ah, here it is:
> 
> 	http://marc.info/?l=linux-usb&m=135876311801537&w=2
> 
> And the new function is devm_ioremap_resource().  We should avoid 
> adding new usages of an old interface.

Maybe... if devm_ioremap_resource() was already in the kernel.  The
problem at the moment is it isn't, and it'll probably be rather
horrid for everyone to deal with especially when it comes to testing.
