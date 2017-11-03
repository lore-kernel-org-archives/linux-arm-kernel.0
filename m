From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 3 Nov 2017 22:28:13 +0100
Subject: device tree bindings for lp5523 leds on N950?
In-Reply-To: <20170822102214.pmag4k2dxz4fdvq5@earth>
References: <20170814133816.GA24493@amd>
 <20170815131518.jt4xff6qv4whebul@earth>
 <20170822102214.pmag4k2dxz4fdvq5@earth>
Message-ID: <20171103212812.GA15026@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> On Tue, Aug 15, 2017 at 09:15:28AM -0400, Sebastian Reichel wrote:
> > Hi Pavel,
> > 
> > On Mon, Aug 14, 2017 at 03:38:16PM +0200, Pavel Machek wrote:
> > > I'm (still) trying to debug "N950 not booting" situation. I'm stuck
> > > with black screen, so I thought it would be cool to use RGB led for
> > > debugging...
> > > 
> > > Unfortunately, I don't see required dts bindings in the mainline.
> > > 
> > > Does anyone have that working?
> > 
> > I have some N950 DTS patches lying around, I think RGB led was one
> > of them. I'm currently in Canda for a company event without my N950,
> > but I should be able to send something tested before the weekend.
> 
> Below is a DTS snippet for N950, that has been tested by me
> on top of 4.13-rc6. The left and right keyboard LEDs are
> also debug LEDs for cpu idle modes, so they will be lit
> without being enabled in lp5523. The status LED of N950 is
> not RGB, but just white. Also you need this to get the driver
> loading. Otherwise detection after reset fails even after
> quite increases waiting times. Looks like the lp5523 reset
> (which is not properly Ack'd by the device) breaks the omap-i2c
> state horribly.

Thanks a lot, LED now works. It took me a while, but I now have n950
usable with nfsroot. (For a while, anyway.)

N9 is usable too. Hardware is similar enough than it could be possible
to debug without serial cable.

Best regards,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171103/76e0020c/attachment.sig>
