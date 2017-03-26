From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 26 Mar 2017 11:12:57 +0200
Subject: script to setup pipeline was Re: [PATCH v4 14/36] [media] v4l2-mc:
 add a function to inherit controls from a pipeline
In-Reply-To: <20170312185845.5c18ffd0@vento.lan>
References: <20170311101408.272a9187@vento.lan>
 <20170311153229.yrdjmggb3p2suhdw@ihha.localdomain>
 <acfb5eca-ff00-6d57-339a-3322034cbdb3@gmail.com>
 <20170311184551.GD21222@n2100.armlinux.org.uk>
 <1f1b350a-5523-34bc-07b7-f3cd2d1fd4c1@gmail.com>
 <20170311185959.GF21222@n2100.armlinux.org.uk>
 <4917d7fb-2f48-17cd-aa2f-d54b0f19ed6e@gmail.com>
 <20170312073745.GI21222@n2100.armlinux.org.uk>
 <fba73c10-4b95-f0d2-e681-0b14ef1fbc1c@gmail.com>
 <20170312185845.5c18ffd0@vento.lan>
Message-ID: <20170326091257.GA17728@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > I do agree with you that MC places a lot of burden on the user to
> > attain a lot of knowledge of the system's architecture.
> 
> Setting up the pipeline is not the hard part. One could write a
> script to do that. 

Can you try to write that script? I believe it would solve big part of
the problem.

> > And my other point is, I think most people who have a need to work with
> > the media framework on a particular platform will likely already be
> > quite familiar with that platform.
> 
> I disagree. The most popular platform device currently is Raspberry PI.
> 
> I doubt that almost all owners of RPi + camera module know anything
> about MC. They just use Raspberry's official driver with just provides
> the V4L2 interface.
> 
> I have a strong opinion that, for hardware like RPi, just the V4L2
> API is enough for more than 90% of the cases.

Maybe V4L2 API is enough for 90% of the users. But I don't believe
that means that we should provide compatibility. V4L2 API is not good
enough for complex devices, and if we can make RPi people fix
userspace... that's a good thing.

> > The media graph for imx6 is fairly self-explanatory in my opinion.
> > Yes that graph has to be generated, but just with a simple 'media-ctl
> > --print-dot', I don't see how that is difficult for the user.
> 
> Again, IMHO, the problem is not how to setup the pipeline, but, instead,
> the need to forward controls to the subdevices.
> 
> To use a camera, the user needs to set up a set of controls for the
> image to make sense (bright, contrast, focus, etc). If the driver
> doesn't forward those controls to the subdevs, an application like
> "camorama" won't actually work for real, as the user won't be able
> to adjust those parameters via GUI.

I believe this can be fixed in libv4l2.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170326/1149c675/attachment.sig>
