From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 12 Mar 2017 22:29:04 +0100
Subject: [PATCH v4 14/36] [media] v4l2-mc: add a function to inherit
 controls from a pipeline
In-Reply-To: <20170311231456.GH21222@n2100.armlinux.org.uk>
References: <20170304131329.GV3220@valkosipuli.retiisi.org.uk>
 <a7b8e095-a95c-24bd-b1e9-e983f18061c4@xs4all.nl>
 <20170310130733.GU21222@n2100.armlinux.org.uk>
 <c679f755-52a6-3c6f-3d65-277db46676cc@xs4all.nl>
 <20170310140124.GV21222@n2100.armlinux.org.uk>
 <cc8900b0-c091-b14b-96f4-01f8fa72431c@xs4all.nl>
 <20170310125342.7f047acf@vento.lan>
 <20170310223714.GI3220@valkosipuli.retiisi.org.uk>
 <20170311082549.576531d0@vento.lan>
 <20170311231456.GH21222@n2100.armlinux.org.uk>
Message-ID: <20170312212904.GA7995@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat 2017-03-11 23:14:56, Russell King - ARM Linux wrote:
> On Sat, Mar 11, 2017 at 08:25:49AM -0300, Mauro Carvalho Chehab wrote:
> > This situation is there since 2009. If I remember well, you tried to write
> > such generic plugin in the past, but never finished it, apparently because
> > it is too complex. Others tried too over the years. 
> > 
> > The last trial was done by Jacek, trying to cover just the exynos4 driver. 
> > Yet, even such limited scope plugin was not good enough, as it was never
> > merged upstream. Currently, there's no such plugins upstream.
> > 
> > If we can't even merge a plugin that solves it for just *one* driver,
> > I have no hope that we'll be able to do it for the generic case.
> 
> This is what really worries me right now about the current proposal for
> iMX6.  What's being proposed is to make the driver exclusively MC-based.
> 
> What that means is that existing applications are _not_ going to work
> until we have some answer for libv4l2, and from what you've said above,
> it seems that this has been attempted multiple times over the last _8_
> years, and each time it's failed.

Yeah. We need a mid-layer between legacy applications and MC
devices. Such layer does not exist in userspace or in kernel.

> Loading the problem onto the user in the hope that the user knows
> enough to properly configure it also doesn't work - who is going to
> educate the user about the various quirks of the hardware they're
> dealing with?

We have docs. Users can write shell scripts. Still, mid-layer would be
nice.

> So, the problem space we have here is absolutely huge, and merely
> having a plugin that activates when you open a /dev/video* node
> really doesn't solve it.
> 
> All in all, I really don't think "lets hope someone writes a v4l2
> plugin to solve it" is ever going to be successful.  I don't even
> see that there will ever be a userspace application that is anything
> more than a representation of the dot graphs that users can use to
> manually configure the capture system with system knowledge.
> 
> I think everyone needs to take a step back and think long and hard
> about this from the system usability perspective - I seriously
> doubt that we will ever see any kind of solution to this if we
> continue to progress with "we'll sort it in userspace some day."

Mid-layer is difficult... there are _hundreds_ of possible
pipeline setups. If it should live in kernel or in userspace is a
question... but I don't think having it in kernel helps in any way.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170312/493191de/attachment-0001.sig>
