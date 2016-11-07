From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 7 Nov 2016 15:11:46 +0100
Subject: [PATCH 0/5] drm/sun4i: Handle TV overscan
In-Reply-To: <CAEqLBRknDAKQu1641BEd_MKe42hYx+Jz8FcASZvC1dn6+yazxg@mail.gmail.com>
References: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
 <20161018092422.GJ1041@n2100.armlinux.org.uk>
 <20161018100349.qm2f554oiwyjwrsi@lukather>
 <20161031084233.GS1041@n2100.armlinux.org.uk>
 <20161103090106.dq2bn4z7m2hzhi53@lukather>
 <CAEqLBRknDAKQu1641BEd_MKe42hYx+Jz8FcASZvC1dn6+yazxg@mail.gmail.com>
Message-ID: <20161107141146.vremdlwdizzejwzd@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

On Thu, Nov 03, 2016 at 03:11:26PM -0600, Sean Paul wrote:
> On Thu, Nov 3, 2016 at 3:01 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi Russell,
> >
> > On Mon, Oct 31, 2016 at 08:42:34AM +0000, Russell King - ARM Linux wrote:
> >> On Tue, Oct 18, 2016 at 12:03:49PM +0200, Maxime Ripard wrote:
> >> > The first one is that this overscanning should be reported by the
> >> > connector I guess? but this is really TV specific, so we need one way
> >> > to let the user tell how the image is displayed on its side, and we
> >> > cannot really autodetect it, and this needs to be done at runtime so
> >> > that we can present some shiny interface to let it select which
> >> > overscan ratio works for him/her.
> >>
> >> See xbmc... they go through a nice shiny setup which includes adjusting
> >> the visible area.  From what I remember, it has pointers on each corner
> >> which you can adjust to be just visible on the screen, so xbmc knows
> >> how much overscan there is, and xbmc itself reduces down to the user
> >> set size.
> >
> > Yes. And that is an XBMC only solution, that doesn't work with the
> > fbdev emulation and is probably doing an additional composition to
> > scale down and center their frames through OpenGL.
> >
> > We might not have a GPU in the system, and we might not even have an
> > entire graphic stack on top either, so I don't think fixing at the
> > user-space level is a good option (especially since we already have an
> > overscan property in DRM).
> >
> 
> Hi Maxime,
> I took a quick look at the first 2 patches in the series and they look
> good at first glance. I have them in my queue to review more
> carefully.

Yes, the first one is pretty scary.

If it can ease your review, I made a bunch of unittests to test that
code. It's pretty hacky (basically a copy of some kernel structures
and the new logic to parse the command line), but it should test it
with a significant number of cases:

http://code.bulix.org/4lnlk7-107122?raw

It's pretty straightforward to compile, you just have to link against
cmocka.

> Can you explain why you can't fix this by specifying a new mode with
> big porches (as Russell suggested)?

I'll reply to his mail.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161107/f6460e69/attachment.sig>
