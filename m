From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 25 Feb 2014 14:05:23 +0100
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <201402251344.23958.arnd@arndb.de>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1563594.ZI2UdY7FPy@wuerfel> <20140223214447.GC3793@kw.sim.vm.gnt>
 <201402251344.23958.arnd@arndb.de>
Message-ID: <20140225130523.GE3793@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 01:44:23PM +0100, Arnd Bergmann wrote:
> On Sunday 23 February 2014, Simon Guinot wrote:
> > I am quite busy this days but as soon I get some free time I will take
> > care of the DT conversion for the Lacie boards.
> > 
> > Basically, we need to fix some minor issues with the Thomas patches:
> > 
> > ARM: kirkwood: convert d2net_v2 to DT
> > ARM: kirkwood: convert LaCie Net{2, 5}Big v2 platforms to DT
> > 
> > And also a DT binding must be added to the LED driver leds-netxbig.
> 
> I just took a brief look at the LED driver. I think it would be
> reasonable to move almost all of the platform_data into the driver
> itself and associate the two versions with distinct "compatible"
> strings. That works in this particular case because while the driver
> is generic enough to handle other cases, I also wouldn't expect
> it to ever get used again on another platform.

Actually, this driver is also used by the Atom-based LaCie NASes.
Mainline support for this platforms should be provided soon.

> 
> The main change to the driver would be to add support for a binding
> that gets the seven gpio numbers out of the DT then.

Unfortunately not, we have to pass the whole thing through DT.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140225/f3fc48f7/attachment.sig>
