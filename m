From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 29 Apr 2016 12:15:06 +0200
Subject: v4l subdevs without big device was Re:
 drivers/media/i2c/adp1653.c: does not show as /dev/video* or v4l-subdev*
In-Reply-To: <20160429075649.GG32125@valkosipuli.retiisi.org.uk>
References: <20160428084546.GA9957@amd> <20160429071525.GA4823@amd>
 <57230DE7.3020701@xs4all.nl>
 <20160429075649.GG32125@valkosipuli.retiisi.org.uk>
Message-ID: <20160429101506.GB22743@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Warning: I'm no DT expert, so this is just a first attempt.
> > 
> > Platform drivers (omap3isp) will have to add these controller devices to the list
> > of subdevs to load asynchronously.
> 
> I seem to have patches I haven't had time to push back then:
> 
> <URL:http://salottisipuli.retiisi.org.uk/cgi-bin/gitweb.cgi?p=~sailus/linux.git;a=shortlog;h=refs/heads/leds-as3645a>
> 
> This seems to be mostly in line with what has been discussed in the meeting,
> except that the patches add a device specific property. Please ignore the
> led patches in that tree for now (i.e. four patches on the top are the
> relevant ones here).

Ok, I attempted to forward-port the patches to v4.6. Not sure if I was successful.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-omap3isp-Fix-async-notifier-registration-order.patch
Type: text/x-diff
Size: 4550 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160429/250b3c03/attachment-0005.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-Solve-conflict-I-missed.patch
Type: text/x-diff
Size: 1354 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160429/250b3c03/attachment-0006.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-Cherry-pick-manually.patch
Type: text/x-diff
Size: 5662 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160429/250b3c03/attachment-0007.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0004-omap3isp-Assign-a-group-ID-for-sensor-and-flash-enti.patch
Type: text/x-diff
Size: 3782 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160429/250b3c03/attachment-0008.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0005-Fix-work-around-compilation.patch
Type: text/x-diff
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160429/250b3c03/attachment-0009.bin>
