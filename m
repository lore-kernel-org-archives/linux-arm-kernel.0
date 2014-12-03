From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 3 Dec 2014 17:52:04 +0100
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <20141128202719.GU2817@atomide.com>
References: <20141027200008.GR2560@atomide.com> <201411270038.01312@pali>
 <20141127011203.GR2817@atomide.com> <201411271232.47231@pali>
 <20141128202719.GU2817@atomide.com>
Message-ID: <20141203165204.GD26685@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2014-11-28 12:27:19, Tony Lindgren wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [141127 03:34]:
> > On Thursday 27 November 2014 02:12:04 Tony Lindgren wrote:
> > > 
> > > Thinking about this probably the best long term solution is
> > > to pass optional board_revision in the kernel cmdline that
> > > can be parsed early and copied to system_rev variable.
> > > 
> > 
> > Not possible. Our bootloader is closed & proprietary. I tried to 
> > replace it with u-boot I was not able to do that. So we will use 
> > that Nokia closed bootloader forever and it can provide data only 
> > in ATAG structure.
> 
> I'm using just mainline u-boot flashed as kernel for nolo that
> then loads the kernel.
> 
> For passing the board revision using the pass through u-boot is
> probably the best long term solution. U-boot can read the ATAGs
> from nolo and modify the .dtb for the revision information.
> 
> Are you saying there are some issues with that?

Plenty :-).

Basically, u-boot is great for production (select one of kernels and
boot it), but pretty much unusable for development:

1) It does not support backlight, so you are interacting blind

2) Setup to load kernels over usb would probably be interesting

3) It makes kernel fail in interesting ways depending on phase of
moon.

Please, keep nolo supported. Debugging kernel & user space is bad,
debugging u-boot & kernel & user space would be even worse.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
