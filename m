From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 26 Oct 2017 11:53:43 +0200
Subject: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
In-Reply-To: <20171026091325.GA26929@amd>
References: <20171025203459.GA22035@amd> <20171025212806.GA21504@atomide.com>
 <20171026091325.GA26929@amd>
Message-ID: <20171026095343.GA31065@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2017-10-26 11:13:26, Pavel Machek wrote:
> On Wed 2017-10-25 14:28:07, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [171025 13:36]:
> > > Hi!
> > > 
> > > ...hardware should be identical. 3.5.3-nemo kernel seems to work on
> > > both. 4.13-rc2 with display and clock patches boots on phone "S", but
> > > does not on phone "P"; nothing nothing is received on serial port.
> > > 
> > > There is some difference in the bootloaders: S's bootloader provides
> > > lots of debug info, P's is silent. R&D settings do _not_ have
> > > influence on bootloader. We know P's serial works, as 3.5.3 kernel
> > > prints "Uncompressing linux...booting" there.
> > > 
> > > I'll need to return "S" phone and serial cable tommorow. If you have
> > > any ideas, let me know.
> > 
> > If you get nothing out of the uart, chances are the pins are
> > not muxed for the uart in nolo and maybe kernel dts is missing the
> > pinctrl entries for uart?
> > 
> > Also try booting with mem=512M at 0x80000000 or 256M or 768M. Maybe the
> > memory is different size or partially broken?
> 
> Uhuh. It looks like "P" nokia really wants initrd, otherwise it will
> not boot.

No. Nokia "P" really hates command line on 0xffff command line. initrd
is optional. It also forces delay on "Warning! You have modified"
... screen.

I configured serial port. Now I get up-to working userspace (initrd)
on both "S" and "P" devices.


Welcome to MOSLO vNEMO_MOSLO-N9_0.0.13.2
Could not ioctl(OMAPFB_UPDATE_WINDOW): Inappropriate ioctl for device
check wiki.merproject.org/wiki/Nemo
Could not ioctl(OMAPFB_UPDATE_WINDOW): Inappropriate ioctl for device

Could not ioctl(OMAPFB_UPDATE_WINDOW): Inappropriate ioctl for device
Waiting for eMMC device...
Could not ioctl(OMAPFB_UPDATE_WINDOW): Inappropriate ioctl for device
eMMC device not found!

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171026/86a19191/attachment.sig>
