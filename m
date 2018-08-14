From: oneukum@suse.com (Oliver Neukum)
Date: Tue, 14 Aug 2018 09:23:06 +0200
Subject: serdev: How to attach serdev devices to USB based tty devices?
In-Reply-To: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
References: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
Message-ID: <1534231386.31827.3.camel@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Di, 2018-08-14 at 04:28 +0200, Andreas F?rber  wrote:
> My idea then was that if we had some unique criteria like vendor and
> product IDs (or whatever is supported in usb_device_id), we could write
> a usb_driver with suitable USB_DEVICE*() macro. In its probe function we
> could call into the existing tty driver's probe function and afterwards
> try creating and attaching the appropriate serdev device, i.e. a fixed
> USB-to-serdev driver mapping. Problem is that most devices don't seem to
> implement any unique identifier I could make this depend on - either by
> using a standard FT232/FT2232/CH340G chip or by using STMicroelectronics
> virtual com port identifiers in CDC firmware and only differing in the
> textual description [3] the usb_device_id does not seem to match on.

If you really must do this you can benignly fail probe(). Thus you
can compare strings within your probe() method.
This sucks because you need to make sure your drivers are always
loaded in a certain order and you really rely on undocumented
properties, but it can be done.

	Regards
		Oliver
