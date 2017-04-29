From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 29 Apr 2017 11:19:19 +0200
Subject: [patch] propagating controls in libv4l2 was Re: support
 autofocus / autogain in libv4l2
In-Reply-To: <20170426082608.7dd52fbf@vento.lan>
References: <1487074823-28274-2-git-send-email-sakari.ailus@linux.intel.com>
 <20170414232332.63850d7b@vento.lan>
 <20170416091209.GB7456@valkosipuli.retiisi.org.uk>
 <20170419105118.72b8e284@vento.lan> <20170424093059.GA20427@amd>
 <20170424103802.00d3b554@vento.lan> <20170424212914.GA20780@amd>
 <20170424224724.5bb52382@vento.lan> <20170426105300.GA857@amd>
 <20170426082608.7dd52fbf@vento.lan>
Message-ID: <20170429091919.GA14148@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > +	devices[index].subdev_fds[0] = SYS_OPEN("/dev/video_sensor", O_RDWR, 0);
> > +	devices[index].subdev_fds[1] = SYS_OPEN("/dev/video_focus", O_RDWR, 0);
> > +	devices[index].subdev_fds[2] = -1;
> 
> Hardcoding names here is not a good idea. Ideally, it should open
> the MC, using the newgen API, and parse the media graph.
> 
> The problem is that, even with newgen API, without the properties API
> you likely won't be able to write a generic parser. So, we need a
> plugin specific for OMAP3 (or at least some database that would teach
> a generic plugin about OMAP3 specifics).
> 
> I guess that the approach that Jacek was taken were very close to what
> a generic plugin would need:
> 	https://lwn.net/Articles/619449/
> 
> The last version of his patch set is here:
> 	https://patchwork.linuxtv.org/patch/37496/
> 
> I didn't review his patchset, but from what I saw, Sakari is the one
> that found some issues on v7.1 patchset.
> 
> Sakari,
> 
> Could you shed us a light about why this patchset was not merged?
> 
> Are there anything really bad at the code, or just minor issues that
> could be fixed later?
> 
> If it is the last case, perhaps we could merge the code, if this
> would make easier for Pavel to work on a N9 solution using the
> same approach.

It would be nice to get some solution here. Camera without libv4l
support is pretty much useless :-(.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170429/5a448afb/attachment.sig>
