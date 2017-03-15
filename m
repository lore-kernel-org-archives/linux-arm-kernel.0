From: nicolas@ndufresne.ca (Nicolas Dufresne)
Date: Wed, 15 Mar 2017 14:55:09 -0400
Subject: media / v4l2-mc: wishlist for complex cameras (was Re: [PATCH
 v4 14/36] [media] v4l2-mc: add a function to inherit controls from a
 pipeline)
In-Reply-To: <20170315105049.GA12099@frolo.macqel>
References: <cc8900b0-c091-b14b-96f4-01f8fa72431c@xs4all.nl>
 <20170310125342.7f047acf@vento.lan>
 <20170310223714.GI3220@valkosipuli.retiisi.org.uk>
 <20170311082549.576531d0@vento.lan>
 <20170313124621.GA10701@valkosipuli.retiisi.org.uk>
 <20170314004533.3b3cd44b@vento.lan>
 <e0a6c60b-1735-de0b-21f4-d8c3f4b3f10f@xs4all.nl>
 <20170314072143.498cde9b@vento.lan> <20170314223254.GA7141@amd>
 <20170314215420.6fc63c67@vento.lan> <20170315105049.GA12099@frolo.macqel>
Message-ID: <1489604109.4593.4.camel@ndufresne.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mercredi 15 mars 2017 ? 11:50 +0100, Philippe De Muyter a ?crit?:
> > I would say: camorama, xawtv3, zbar, google talk, skype. If it runs
> > with those, it will likely run with any other application.
> > 
> 
> I would like to add the 'v4l2src' plugin of gstreamer, and on the
> imx6 its

While it would be nice if somehow you would get v4l2src to work (in
some legacy/emulation mode through libv4l2), the longer plan is to
implement smart bin that handle several v4l2src, that can do the
required interactions so we can expose similar level of controls as
found in Android Camera HAL3, and maybe even further assuming userspace
can change the media tree at run-time. We might be a long way from
there, specially that some of the features depends on how much the
hardware can do. Just being able to figure-out how to build the MC tree
dynamically seems really hard when thinking of generic mechanism. Also,
Request API will be needed.

I think for this one, we'll need some userspace driver that enable the
features (not hide them), and that's what I'd be looking for from
libv4l2 in this regard.

> imx-specific counterpart 'imxv4l2videosrc' from the gstreamer-imx
> package
> at https://github.com/Freescale/gstreamer-imx, and 'v4l2-ctl'.

This one is specific to IMX hardware using vendor driver. You can
probably ignore that.

Nicolas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170315/6895c2fe/attachment.sig>
