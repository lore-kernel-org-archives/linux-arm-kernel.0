From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Apr 2014 22:49:07 +0200
Subject: [PATCH v2] staging: imx-drm-core: skip components whose parent
 device is disabled
In-Reply-To: <20140421233148.GZ2523@dragon>
References: <1397440946-2303-1-git-send-email-shawn.guo@freescale.com>
 <CAOesGMiDqd+JSd_fzzeWohSGixuR1ciOz_FO5CGnSm7F3ioxDw@mail.gmail.com>
 <20140421233148.GZ2523@dragon>
Message-ID: <201404222249.07486.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 April 2014, Shawn Guo wrote:
> On Mon, Apr 21, 2014 at 07:22:52AM -0700, Olof Johansson wrote:
> > On Sat, Apr 19, 2014 at 4:00 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> > > On Sat, Apr 19, 2014 at 09:42:29AM +0100, Russell King - ARM Linux wrote:
> > >> On Sat, Apr 19, 2014 at 01:53:08PM +0800, Shawn Guo wrote:
> > >> > BTW, can you take a look at the following two patches, or are they
> > >> > already in your queue?
> > >> >
> > >> > imx-drm: imx-drm-core: Fix imx_drm_encoder_get_mux_id
> > >> > https://lkml.org/lkml/2014/4/7/58
> > >>
> > >> This one now is.
> > >>
> > >> > mx-drm: imx-tve: correct DDC property name to 'ddc-i2c-bus'
> > >> > ('i' is missing from the prefix word, and it should be 'imx-drm')
> > >> > http://www.spinics.net/lists/arm-kernel/msg321057.html
> > >>
> > >> This one touches arch/arm/boot/dts, which Arnd moaned at me for touching
> > >> via the staging tree during the merge window.  So, while I can take the
> > >> imx-tve part, I can't take the arch/arm/boot/dts part.  This patch needs
> > >> to be split.
> > >>
> > >> It also means that the MBA platform will have its TVE output broken while
> > >> the two commits take their different paths, but I guess that's what you
> > >> get for this kind of sillyness about git trees having exclusive ownership
> > >> of various files in the kernel tree - more breakage not less.
> > >
> > > I think Arnd's main concern is about merge conflict, which shouldn't be
> > > a problem for this particular case.  The change on dts file is pretty
> > > trivial.  And I assume this is a fix to be landed on mainline before
> > > -rc5 or so.  Then I can rebase my DT branch on top of it.  That said,
> > > merge conflict is not really a problem for this patch.  Arnd?
> > 
> > I'm not Arnd, but that should work well.
> 
> Thanks, Olof.

Just to clarify, we generally want to avoid three things that happened
with this driver during the merge window:

- incompatible DT binding changes
- known merge conflicts
- dts changes going through another tree (because they tend to cause
  merge conflicts)

However, none of these are hard rules, we can bend them for good reasons
if it's clearly spelled out in the patch description and we are aware
of the change (ideally with an explicit Ack).

	Arnd
