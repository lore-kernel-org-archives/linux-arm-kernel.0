From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 7 Apr 2015 12:40:16 +0000
Subject: irqchip heirarchy DT "break" series awareness?
In-Reply-To: <20150407115922.5d4c6233@free-electrons.com>
References: <20150406144647.GC7873@io.lakedaemon.net>
 <20150407115922.5d4c6233@free-electrons.com>
Message-ID: <20150407124016.GD7873@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Thomas,

On Tue, Apr 07, 2015 at 11:59:22AM +0200, Thomas Petazzoni wrote:
> Jason,
> 
> On Mon, 6 Apr 2015 14:46:47 +0000, Jason Cooper wrote:
> 
> > This causes two problems:
> > 
> >  1) Upgrade kernel, but not DTB.
> > 
> > 	System will boot, and print a big fat warning that
> > 	suspend/resume will not work until the DTB is upgraded.
> > 
> >  2) Upgrade DTB, but not kernel.
> > 
> > 	System will fail to boot.
> 
> (2) has never been something that has ever planned of being guaranteed,
> as far as I know. Only (1) is the supposed consequence of DT ABI
> stability, but definitely not (2), so I'm unsure why you even mention
> (2).

Because my goal here was to give *every* possible chance for an
objection.  Hence, "dt" and "break" in the subject line, sent to the
devicetree ML.  Also, Marc mentioned the possibility in at least the
cover letter of each of his series.  I don't want anything hidden.

But you are absolutely correct.  (2) was never guaranteed, and it's also
highly improbable as well.  See below.

> > In light of Thomas Petazonni's well-researched talk at ELC:
> > 
> >   "The Device Tree as a stable ABI: a fairy tale?"
> >   http://events.linuxfoundation.org/sites/events/files/slides/petazzoni-dt-as-stable-abi-fairy-tale.pdf
> > 
> > I'm confident that #2 won't be an issue.  Distro's and OEMs seem to have
> > worked around the instability by keeping the dtb tied to the kernel
> > version.
> 
> I'm glad you raised my slides as an argument in a DT ABI stability
> discussion :-)
> 
> However, my slides are definitely not about #2 (which as said earlier,
> was never planned to be something we should worry about), but really
> about #1.

I was referring to the slide where you mention that distros and vendors
have tied the dtbs to the kernel versions (Slide 23/27, "Usefulness").
I should have been more specific when taking something out of context.
:-P

My point, not well made, was that everyone has decided to slave the
upgrade of the dtb to the upgrade of the kernel.  There is no 'apt-get
armv7-dtbs' that has no dependency structure on a kernel package.  So we
agree, (2) was never guaranteed, and isn't probable either.

thx,

Jason.
