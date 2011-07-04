From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 4 Jul 2011 22:39:41 +0200
Subject: Future of S3C6410 platform
In-Reply-To: <2635745.FvrjgPkNLz@flatron>
References: <2635745.FvrjgPkNLz@flatron>
Message-ID: <201107042239.41833.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 July 2011 21:14:19 Tomasz Figa wrote:
> I am writing to ask what is the planned future for the (now obsolete?) S3C6410 
> platform. Is there any ongoing work on bringing more feature-complete support 
> for it?

I guess you should ask the maintainer directly, now on Cc. I wouldn't call
s3c6410 obsolete, we have much much older platforms that are still supported
well. Of course, many people are overworked and need to set priorities,
so it's understandable if there are fewer patches to improve the less
current platforms.

> The platform is really far behind its newer friends and here is what bothers 
> me most:
> - missing basic features as NOHZ support
> - buggy drivers (in mainline!, s3c-fb requesting irq before fully initializing 
> driver data, same goes for the adc driver)
> - totally broken usb gadget driver - I could not get it to work on my platform 
> in any way (Samsung GT-i5700 phone; I am getting a Tiny6410 soon, so I will 
> check whether it is not a board specific issue) without rewriting control 
> endpoint handling code, not even mentioning about DMA support, which I still 
> cannot get to work
> - poor OneNAND support (mostly in terms of performance)
> - no power domain support
> - no support for advanced features of the chip (ie. functionality provided by 
> old, and really _bad_, s3c modules)
> 
> I have already added NOHZ support, fixed fb and adc bugs, refactored control 
> endpoint handling in udc driver (no DMA yet), done some improvement to OneNAND 
> driver (still a big work in progress though, this is a topic for another 
> message) and implemented power domain management + other minor changes/fixes. 

In general, patches that fix bugs are always welcome, and so are patches
that add functionality and device drivers. Even device drivers that are
not good enough for inclusion can often get merged into the drivers/staging
directory, if there is hope that the quality of the code is improving
over time.

> All of this is available in my tree at 
> git://github.com/tom3q/spica-2.6.38.git, but I am going to prepare patches 
> containing all the changes a bit later, after I rebase all my work to latest 
> Linux sources, as I worked mostly on Android 2.6.38 sources.

Yes, that is a necessary step for getting your code contributions into
the mainline kernel. You should also read Documentation/SubmittingPatches
carefully, to avoid a frustrating experience from the first submission of
a large patch set.

I would recommend that you have your patches reviewed in private by a person
you know first, and then post them on the mailing list for a broader review.

	Arnd
