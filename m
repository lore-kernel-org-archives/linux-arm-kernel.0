From: gregkh@suse.de (Greg KH)
Date: Thu, 15 Jul 2010 09:51:41 -0700
Subject: tq 2440
In-Reply-To: <20100715163526.GJ29322@n2100.arm.linux.org.uk>
References: <AANLkTimyBHliUa62qmfja_ke6YTTysiVAtJcZfi8l2gG@mail.gmail.com>
	<AANLkTil8GE1OguyAfp3XgfJvEmH98yNrlvGAx684a-qL@mail.gmail.com>
	<20100715163526.GJ29322@n2100.arm.linux.org.uk>
Message-ID: <20100715165141.GA21272@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 15, 2010 at 05:35:26PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 15, 2010 at 11:16:30PM +0800, Conke Hu wrote:
> > ever notice to the following kernel log?
> > "Device 's3c2440-nand' does not have a release() function, it is
> > broken and must."
> > release() function should be implemented  in the platform_device.
> 
> That's not telling you to provide a release function.  The warning is
> telling you that a device is being unregistered which doesn't have a
> release function.
> 
> Consider this point - maybe it doesn't have a release function because
> it's not supposed to be unregistered?

Heh, well, it is being unregistered, and at that point in time, the
kernel complains.

All kobjects need a release function that actually frees it.  If not,
that is a logic bug.  Please see the Documentation/kobject.txt file for
details.

thanks,

greg k-h
