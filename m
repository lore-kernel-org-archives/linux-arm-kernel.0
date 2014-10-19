From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 19 Oct 2014 21:19:37 +0200
Subject: USB Ethernet gadget on Nokia n900
In-Reply-To: <20141019152414.GB5189@saruman>
References: <20141019090107.GA19132@amd> <20141019100739.GA2547@amd>
 <20141019152414.GB5189@saruman>
Message-ID: <20141019191937.GA6438@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Sun 2014-10-19 10:24:14, Felipe Balbi wrote:
> Hi,
> On Sun, Oct 19, 2014 at 12:07:39PM +0200, Pavel Machek wrote:
> > On Sun 2014-10-19 11:01:07, Pavel Machek wrote:
> > > Hi!
> > > 
> > > From 3.6 to 3.10, USB networking works on Nokia N900. With 3.11, it
> > > fails with messages on the host. I also tried to get it to work on
> > > 3.14 and 3.17, with no luck.
> > > 
> > > Any ideas? Does it work for you? Any config options to watch for?
> > 
> > With 3.17, I get
> > 
> > omap_musb_mailbox: musb core is not yet ready
> > 
> > message. It looks related...?
> 
> is musbmhdrc.ko loaded ? Do you have a gadget driver loaded ?
> 
> + Aaro

I am trying to use nfsroot, so I can't use modules. I can't find
musbmhdrc.ko; did you mean drivers/usb/musb/musb_hdrc? Yes, that
should be build-in:

CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_GADGET=y
CONFIG_USB_MUSB_OMAP2PLUS=y
CONFIG_MUSB_PIO_ONLY=y

Gadget options are:

CONFIG_USB_ULPI=y
CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_DEBUG=y
CONFIG_USB_GADGET_VERBOSE=y
CONFIG_USB_GADGET_DEBUG_FILES=y
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_U_ETHER=y
CONFIG_USB_F_ECM=y
CONFIG_USB_F_EEM=y
CONFIG_USB_F_SUBSET=y
CONFIG_USB_F_RNDIS=y

(I am attaching full config, in case I missed something important).

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23072 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141019/830aff75/attachment-0001.gz>
