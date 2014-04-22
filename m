From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Apr 2014 22:55:06 +0100
Subject: [PATCH v2] staging: imx-drm-core: skip components whose parent
 device is disabled
In-Reply-To: <201404222249.07486.arnd@arndb.de>
References: <1397440946-2303-1-git-send-email-shawn.guo@freescale.com>
 <CAOesGMiDqd+JSd_fzzeWohSGixuR1ciOz_FO5CGnSm7F3ioxDw@mail.gmail.com>
 <20140421233148.GZ2523@dragon> <201404222249.07486.arnd@arndb.de>
Message-ID: <20140422215506.GC24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 10:49:07PM +0200, Arnd Bergmann wrote:
> Just to clarify, we generally want to avoid three things that happened
> with this driver during the merge window:
> 
> - incompatible DT binding changes

FFS, this is a _staging_ driver which hasn't had the bindings settled.
They're _still_ not settled, because there's _still_ the discussion on
the graph bindings to finally sort out and resolve.  So I wouldn't be
surprised if there are _more_ incompatible binding changes to come.

Meanwhile, we _have_ to keep the driver in a working state so that
people can use and develop against it, and most importantly, resolve
problems with the bindings.

Coming up with _decent_ bindings for subsystems like DRM is still very
much a work in progress.

I guess we could keep this stuff 100% out of the tree, which blocks a
whole load of people, forces people towards vendor kernels, or just
forces people away from Linux because Linux is "too hard" and people
are "too difficult" to work with, and it takes _far_ too long to get
stuff into a working state.

How long does it take to make any kind of progress with a driver in a
mainline kernel?  One cycle?  Two cycles?  A year?

The reality is that it takes around _ONE_ year or longer _PER_ driver.

I wonder why people give up and just end up using vendor kernels...
because they just can't be bothered with mainline.

> - known merge conflicts
> - dts changes going through another tree (because they tend to cause
>   merge conflicts)
> 
> However, none of these are hard rules, we can bend them for good reasons
> if it's clearly spelled out in the patch description and we are aware
> of the change (ideally with an explicit Ack).

So care to explain why there were _zero_ merge conflicts from -rc time
before the merge window up to about a week _into_ the merge window, and
then suddenly arm-soc starts conflicting not only locally here but _also_
in linux-next.

That stinks of arm-soc merging new stuff *during* the merge window.

And don't try to deny that - remember, I run a build system here locally,
and I _manually_ merge Linus' tip into my tip (which contains *everything*
including the staged changes for imx-drm and those binding changes) _and_
finally arm-soc's for-next branch, and there were _zero_ conflicts at the
start of the merge window.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
