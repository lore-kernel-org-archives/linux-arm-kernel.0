From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 10 Nov 2009 14:38:42 +0100
Subject: [PATCH] ARM: SAMSUNG: Add plat-samsung as starting point for
	plat-s3c* moves
In-Reply-To: <20091110094756.GN4048@prithivi.gnumonks.org>
References: <1257812406-17360-1-git-send-email-ben-linux@fluff.org>
	<000a01ca61a5$c573d000$505b7000$%kim@samsung.com>
	<9c9fda240911091927m46ed0fccyfbbc8873eb9c5da9@mail.gmail.com>
	<20091110094756.GN4048@prithivi.gnumonks.org>
Message-ID: <000001ca620b$2141c080$63c54180$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, November 10, 2009 10:48 AM, Harald Welte wrote:

> Dear Kyungmin,
> 
> On Tue, Nov 10, 2009 at 12:27:15PM +0900, Kyungmin Park wrote:
> > >
> > >> We inted to re-organise the plat-s3c/plat-s3c24xx/plat-s3c64xx into a
> > >> more generic plat-samsung with less code in the other plat- directories
> > >> to make it easier to port new devices and try and clear up some of the
> > >> naming issues with newer devices.
> >
> > Why do you miss the plat-s5pc1xx? Also add the plat-s5pc1xx series.
> 
> Of course.  The code for the C100, C110, V210, etc. is also subject to
> this.  Maybe Ben simply wanted to be polite and indicate he does not
> intend to interfere with your current codebase.  After all, DMC is the
> maintainer of the C100 support in mainline, and we hope we can have your
> cooperation with this new structure.  But since we did not ask you yet,
> we couldn't assume that you would agree.

We are also interested in improving mainline support for C100 series as
well as upcoming C110.

> > Why new plat-s5p is required? The main goal of plat-* directory is
> > support the SoC common codes.
> 
> plat-samsung is intended for stuff that's shared between all the various
> arm9/arm11/a8 based SoCs.  This is so far in plat-s3c, even though it's
> not only used (and will not only be used) by s3c parts.

So most of the current code from plat-s3c (mainly common dev-* platform
resources, clocks, uart and gpio core functions) would be moved to
plat-samsung? Right?

> > Of course s5pc100 and s5pc110 is different features and different IPs
> > but no need to create each plat directory.
> 
> The 6440 shares some things with the c100, and the 6442 shares again
> some things with the c110.  So putting all those files into one
> directory seems to make it much easier to share code between the
> different parts as needed.  Also, it means that we have to do less
> moving around.
> 
> Imagine we continue with one plat-s5p64xx and plat-s5pc1xx, etc. for
> each new SoC.  Later we detect there is some sharing with an earlier
> product, then we need to move the file to plat-s5p.  This moving around
> of files causes breakage in patches that people are having in their
> private trees before they can move it mainline.
> 
> Also, don't you think it is somewhat weird that soon samsung would have
> as many plat-* directories as all other ARM SoC makers together?

These multiple plat-* directories for all Samsung chip series are in
fact a big overhead for kernel tree. I assume that You want to end with
only one plat-samsung directory. Am I right? What about multiple mach-*
directories (mach-s3c2400, ..., mach-s3c24a0, mach-s3c6400, mach-s3c6410,
mach-s5pc100, ...)? Do you plan to keep them? Maybe a multilevel structure
would be more aproperiate? (mach-samsung/s3c2400, mach-samsung/s3c6400, 
and so on)?

How do you plan to handle different includes, register map, register
offset defines, etc in each chip series? Would this result in moving
the series specific include directories to mach-* directories?

How can we adapt the current plat-s5pcxx code to better match the
migration to common plat-samsung directory?

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
