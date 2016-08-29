From: linux@mniewoehner.de (Michael =?ISO-8859-1?Q?Niew=F6hner?=)
Date: Mon, 29 Aug 2016 13:05:30 +0200
Subject: PROBLEM: DWC3 USB 3.0 not working on Odroid-XU4 with Exynos 5422
In-Reply-To: <57C41582.1030604@linux.intel.com>
References: <1472414695.3845.3.camel@mniewoehner.de>
 <87lgzgdof3.fsf@linux.intel.com> <57C41582.1030604@linux.intel.com>
Message-ID: <1472468730.4925.3.camel@mniewoehner.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathias,
On Mo, 2016-08-29 at 13:59 +0300, Mathias Nyman wrote:
> On 29.08.2016 10:28, Felipe Balbi wrote:
> > 
> > 
> > Hi,
> > 
> > Michael Niew?hner <linux@mniewoehner.de> writes:
> > > 
> > > [1.] One line summary of the problem:
> > > DWC3 USB 3.0 not working on Odroid-XU4 with Exynos 5422
> > > 
> > > [2.] Full description of the problem/report:
> > > No usb 3.0 devices are being detected when attached while USB 2.0
> > > devices work on the same port.
> > > USB 3.0 works after applying patches [9.1] and [9.2], but seems
> > > to be
> > > buggy. The usb hub is redetected every time an usb device is
> > > attached.
> > 
> > dwc3 is host, which means it's actually XHCI :-)
> > 
> > Adding Mathias
> > 
> > > 
> > > dmesg:
> > > [??192.287080] usb 3-1.2: USB disconnect, device number 7
> > > [??210.370699] hub 3-1:1.0: hub_ext_port_status failed (err =
> > > -71)
> 
> Looks like the hub GetPortStatus request fails with protocol error.
> 
> Reading xhci root hub port status is mostly just register reads and
> writes. It
> shouldn't include any actual transfers that could return -EPROTO
> 
> So this is not the root hub? but a external or integrated on your
> board, right?
> 
> The protocol error -71 is returned at transfer errors or if device
> stalled.
> 
> Adding more xhci debugging options could show something:
> echo -n 'module xhci_hcd =p' >
> /sys/kernel/debug/dynamic_debug/control
> 
> > 
> > > 
> > > [9.] Other notes, patches, fixes, workarounds:
> > > [9.1] https://lkml.org/lkml/2014/4/28/234
> > > [9.2] https://lkml.org/lkml/2015/2/2/259
> 
> The additional patches that makes things somehow work involve tuning
> the PHY,
> this is an area I'm not familiar with
> 
> -Mathias
> 


I'm sorry, I should have said that this is the dmesg output with the
patches applied. Without them there is no output at all when I attach
an usb 3.0 device.

Michael
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 630 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160829/c0397bee/attachment.sig>
