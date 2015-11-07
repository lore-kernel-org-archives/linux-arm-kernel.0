From: sre@kernel.org (Sebastian Reichel)
Date: Sat, 7 Nov 2015 03:44:57 +0100
Subject: [PATCH] Revert "ARM: dts: twl4030: Add iio properties for bci
 subnode"
In-Reply-To: <20151107091925.7dcd14a7@canb.auug.org.au>
References: <1446826430-3705-1-git-send-email-sre@kernel.org>
 <CAMAWPa-7_q8Sf+4VQ0EE6zU-NvacKERFgjqueNif=52Frn0enA@mail.gmail.com>
 <20151107091925.7dcd14a7@canb.auug.org.au>
Message-ID: <20151107024457.GA18676@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Nov 07, 2015 at 09:19:25AM +1100, Stephen Rothwell wrote:
> On Fri, 6 Nov 2015 10:36:34 -0800 Kevin Hilman <khilman@kernel.org> wrote:
> > On Fri, Nov 6, 2015 at 8:13 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > > This reverts commit af19161aaed7ff8d1a52b2e517460f2fa0774e32,
> > > which breaks the omap3 device tree build due to a wrong reference.
> > >
> > > I accidently queued this change via the power supply subsystem while
> > > telling Marek at the same time, that it should go through Tony's tree.
> > > Following that I did miss Stephen's messages about the build failure in
> > > linux-next and since he switched to merging an older snapshot nobody
> > > else noticed the problem in my tree. I didn't notice myself, since I
> > > did not build any device tree files assuming none have changed by me.
> > >
> > > Signed-off-by: Sebastian Reichel <sre@kernel.org>  
> > 
> > We also found this in kernelci.org build testing, and verified that
> > this fixes the build.
> > 
> > Tested-by: Kevin Hilman <khilman@linaro.org>
> > 
> > Thanks Felipe for reporting, and thanks Sebastian for the quick fix.
> 
> I think "quick fix" is a bit rich.  I reported this to Sebastian on
> Sept 29, Oct 2 , Oct 8, Oct 16, and Oct 21.

Yes, I did see them after searching for them. My filter rules put
your mails together with the LKML mails (which I usually skip over
quite fast), so I did not notice the first one. Since the follow up
mails were in the same thread as the one(s) previously marked as
dont-care, I didn't notice them either.

> The only response I got was from Marek Belisko on Oct 8 and 21. I
> have been using the battery tree (git://git.infradead.org/battery-2.6.git#master)
> from Sept 25, so none of the commits after that have been in any linux-next
> release.
>
> Yes, I am a little annoyed.

Sorry :(

> Do people have trouble receiving my emails?

I did create two extra rules for your mails directly after preparing
the revert, so I hope it won't happen again.

On Sat, Fri, 6 Nov 2015 14:36:25 -0800, Kevin Hilman wrote:
> I don't think the problem was not getting your emails, looks like the
> problem was a major disconnect between what was sent to Linus and what
> was in -next. :(

Is there an easy way to check this, so that I can create a cronjob
checkin it? Having an additional automatic "your tree differs from
linux-next" would be helpful, since that would make me search for
the problem/a mail from Stephen.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151107/82e62c58/attachment.sig>
