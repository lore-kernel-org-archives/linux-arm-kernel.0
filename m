From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 11 Mar 2017 22:30:54 +0100
Subject: [PATCH v4 14/36] [media] v4l2-mc: add a function to inherit
 controls from a pipeline
In-Reply-To: <20170311101408.272a9187@vento.lan>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-15-git-send-email-steve_longerbeam@mentor.com>
 <20170302160257.GK3220@valkosipuli.retiisi.org.uk>
 <20170303230645.GR21222@n2100.armlinux.org.uk>
 <20170304131329.GV3220@valkosipuli.retiisi.org.uk>
 <a7b8e095-a95c-24bd-b1e9-e983f18061c4@xs4all.nl>
 <20170310120902.1daebc7b@vento.lan>
 <5e1183f4-774f-413a-628a-96e0df321faf@xs4all.nl>
 <20170311101408.272a9187@vento.lan>
Message-ID: <20170311213054.GA7319@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > Ok, perhaps supporting both subdev API and V4L2 API at the same
> > > time doesn't make much sense. We could disable one in favor of the
> > > other, either at compilation time or at runtime.  
> > 
> > Right. If the subdev API is disabled, then you have to inherit the subdev
> > controls in the bridge driver (how else would you be able to access them?).
> > And that's the usual case.
> > 
> > If you do have the subdev API enabled, AND you use the MC, then the
> > intention clearly is to give userspace full control and inheriting controls
> > no longer makes any sense (and is highly confusing IMHO).
> 
> I tend to agree with that.

Well, having different userspace interface according to config options
is strange. I believe the right solution is to make complex drivers
depend on CONFIG_VIDEO_V4L2_SUBDEV_API...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170311/e1dd4344/attachment-0001.sig>
