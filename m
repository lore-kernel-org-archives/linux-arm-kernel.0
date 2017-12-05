From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 5 Dec 2017 19:01:07 +0100
Subject: [RFC PATCH 1/6] drm: Add Content Protection property
In-Reply-To: <CADnq5_PcbBeGL+3CxOpNgRiih4czU9SnmjNbRyyRHOn-OZvy5Q@mail.gmail.com>
References: <20171130030907.26848-1-seanpaul@chromium.org>
 <20171130030907.26848-2-seanpaul@chromium.org>
 <20171205102840.GB12982@amd>
 <20171205104538.b4fxdjad3c46koas@phenom.ffwll.local>
 <20171205173408.GA18425@amd>
 <CADnq5_PcbBeGL+3CxOpNgRiih4czU9SnmjNbRyyRHOn-OZvy5Q@mail.gmail.com>
Message-ID: <20171205180107.GA22672@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >> > Why would user of the machine want this to be something else than
> >> > 'OFF'?
> >> >
> >> > If kernel implements this, will it mean hardware vendors will have to
> >> > prevent user from updating kernel on machines they own?
> >> >
> >> > If this is merged, does it open kernel developers to DMCA threats if
> >> > they try to change it?
> >>
> >> Because this just implements one part of the content protection scheme.
> >> This only gives you an option to enable HDCP (aka encryption, it's really
> >> nothing else) on the cable. Just because it has Content Protection in the
> >> name does _not_ mean it is (stand-alone) an effective nor complete content
> >> protection scheme. It's simply encrypting data, that's all.
> >
> > Yep. So my first question was: why would user of the machine ever want
> > encryption "ENABLED" or "DESIRED"? Could you answer it?
> 
> How about for sensitive video streams in government offices where you
> want to avoid a spy potentially tapping the cable to see the video
> stream?

Except that spies already have the keys, as every monitor
manufacturer has them?

> >> kernels and be able to exercise their software freedoms already know to
> >> avoid such locked down systems.
> >>
> >> So yeah it would be better to call this the "HDMI/DP cable encryption
> >> support", but well, it's not what it's called really.
> >
> > Well, it does not belong in kernel, no matter what is the name.
> 
> Should we remove support for encrypted file systems and encrypted
> virtual machines?  Just like them the option is there is you want to
> use it.  If you don't want to, you don't have to.

Encrypted file systems benefit users. Encrypted video is designed to
work against users. In particular, users don't have encryption keys
for video they generate. I'd have nothing against feature that would
let users encrypt video with keys they control.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171205/179f88b1/attachment.sig>
