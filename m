From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 25 Apr 2017 10:20:41 +0200
Subject: support autofocus / autogain in libv4l2
In-Reply-To: <20170424225731.7532e368@vento.lan>
References: <1487074823-28274-1-git-send-email-sakari.ailus@linux.intel.com>
 <1487074823-28274-2-git-send-email-sakari.ailus@linux.intel.com>
 <20170414232332.63850d7b@vento.lan>
 <20170416091209.GB7456@valkosipuli.retiisi.org.uk>
 <20170419105118.72b8e284@vento.lan> <20170424093059.GA20427@amd>
 <20170424103802.00d3b554@vento.lan> <20170424220701.GA27846@amd>
 <20170424225731.7532e368@vento.lan>
Message-ID: <20170425082041.GB30380@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > Please don't add a new application under lib/. It is fine if you want
> > > some testing application, if the ones there aren't enough, but please
> > > place it under contrib/test/.
> > > 
> > > You should likely take a look at v4l2grab first, as it could have
> > > almost everything you would need.  
> > 
> > I really need some kind of video output. v4l2grab is not useful
> > there. v4l2gl might be, but I don't think I have enough dependencies.
> 
> Well, you could use some app to show the snaps that v4l2grab takes.

That would be too slow :-(.

> Yeah, compiling v4l2gl on N9 can indeed be complex. I suspect that it 
> shouldn't hard to compile xawtv there (probably disabling some optional
> features).

I do have mplayer working, but that one is not linked against libv4l2
:-(.

> > Umm, and it looks like libv4l can not automatically convert from
> > GRBG10.. and if it could, going through RGB24 would probably be too
> > slow on this device :-(.
> 
> I suspect it shouldn't be hard to add support for GRBG10. It already
> supports 8 and 16 bits Bayer formats, at lib/libv4lconvert/bayer.c
> (to both RGB and YUV formats).

Is 16bit bayer a recent development? I can't see it in

commit 374806e868f5a7a48ecffde4c6a1abfcfa5ccd65
Author: Hans Verkuil <hans.verkuil@cisco.com>
Date:   Fri Apr 22 09:31:57 2016 +0200

> > Is there an example using autogain/autowhitebalance from
> > libv4lconvert?
> 
> Well, if you plug a USB camera without those controls, it should
> automatically expose controls for it, as if the device had such
> controls.

And settings are persistent, so I can enable autogain, then lauch
something like xawtv, and it will automatically get autogain? Ok,
good.

Regards,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170425/23ad62a6/attachment.sig>
