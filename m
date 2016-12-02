From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 2 Dec 2016 11:42:08 +0100
Subject: XHCI controller does not detect USB key insertion
In-Reply-To: <58414BC5.109@free.fr>
References: <584134D9.5000404@free.fr> <87inr2vh2l.fsf@linux.intel.com>
 <58414BC5.109@free.fr>
Message-ID: <20161202104208.GA8736@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 11:24:05AM +0100, Mason wrote:
> >> # lsusb -v
> >> Bus 001 Device 001: ID 1d6b:0002
> >> Bus 002 Device 001: ID 1d6b:0003
> 
> Isn't lsusb verbose supposed to print much more than that?

Yes, if you are using the usbutils version of 'lsusb', odds are this is
busybox, right?

And these are just the root hubs, that the USB controller driver creates
as "virtual" USB devices, they are not "real" USB devices on your bus.

hope this helps,

greg k-h
