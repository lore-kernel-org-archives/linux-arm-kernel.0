From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 26 Jun 2013 10:51:10 -0700
Subject: [PATCH 1/2] Initial support for Allwinner's Security ID fuses
In-Reply-To: <20130626091032.GE2718@n2100.arm.linux.org.uk>
References: <1371502778-15849-1-git-send-email-oliver+list@schinagl.nl>
 <1371502778-15849-2-git-send-email-oliver+list@schinagl.nl>
 <20130617225847.GA9494@kroah.com> <20130624092942.GG26008@lukather>
 <20130624160440.GA15201@kroah.com> <51C87DC7.50005@schinagl.nl>
 <20130624181509.GA8847@kroah.com> <51C8B84C.3020200@schinagl.nl>
 <20130624214615.GA17604@kroah.com>
 <20130626091032.GE2718@n2100.arm.linux.org.uk>
Message-ID: <20130626175110.GB2222@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 10:10:33AM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 24, 2013 at 02:46:15PM -0700, Greg KH wrote:
> > Stick with a binary attribute, and attach that to the proper class
> > structure and all should be fine.
> > 
> > Ah crap, you're using a platform device.
> > 
> > {sigh}
> > 
> > Why?  Why not use a "real" device which has a "real" class, and then use
> > the interfaces there?
> 
> And why aren't platform devices "real" devices?  If platform devices are
> second class devices then that's pretty crap because virtually all
> devices on ARM are platform devices, not something like "first class"
> PCI devices.

Ok, they are "real" devices, I'm just tired of seeing people throw
everything and the kitchen sink into them, don't you agree?

> We could make them PCI devices if you want us to totally fsck with the
> PCI code to bend it in ways it was never meant to, but I suspect that'll
> upset the PCI guys.
> 
> No, platform devices must be first class devices just like any other.

I was wrong, they can, and do, support default attribute groups, it's
just that it seems no one uses them (or if they did, my greping can't
find them...)

So they are "first class" devices, my mistake.

thanks,

greg k-h
